extends Node

# Main rhythm game controller
# Connects metronome, input detection, judgment, and scoring

signal rhythm_hit(result, score, timing_offset)

@onready var metronome = Metronome
@onready var currency_manager = CurrencyManager

var input_judge: Node

var is_active: bool = false
var combo_count: int = 0
var total_hits: int = 0
var perfect_hits: int = 0
var good_hits: int = 0
var missed_hits: int = 0

func _ready():
	# Create InputJudge instance
	input_judge = preload("res://scripts/core/InputJudge.gd").new()
	add_child(input_judge)
	
	# Connect to input judge signals
	input_judge.hit_judged.connect(_on_hit_judged)

func activate():
	is_active = true

func deactivate():
	is_active = false

func handle_rhythm_input():
	if not is_active:
		return
	
	total_hits += 1
	
	# Get timing offset from metronome - expand window to capture all possible hits
	var timing_offset_ms = metronome.is_near_beat(200.0)  # Check within 200ms window
	
	# Convert to seconds for input judge, but handle the "miss" case (999.0)
	var timing_offset_seconds: float
	if timing_offset_ms >= 999.0:
		timing_offset_seconds = 1.0  # Large value to indicate clear miss
	else:
		timing_offset_seconds = timing_offset_ms / 1000.0  # Convert ms to seconds
	
	# Judge the input timing
	var judgment = input_judge.judge_input_timing(timing_offset_seconds)
	
	# Clean output - only show successful hits
	if judgment.result != InputJudge.HitResult.MISS:
		var result_names = ["MISS", "GOOD", "PERFECT"]
		print(result_names[judgment.result], "! +", judgment.score, " Groove")
	
	# Update statistics
	match judgment.result:
		InputJudge.HitResult.PERFECT:
			perfect_hits += 1
			combo_count += 1
		InputJudge.HitResult.GOOD:
			good_hits += 1
			combo_count += 1
		InputJudge.HitResult.MISS:
			missed_hits += 1
			combo_count = 0  # Break combo on miss
	
	# Award groove points
	var groove_reward = calculate_groove_reward(judgment.score)
	if groove_reward > 0:
		currency_manager.add_groove(groove_reward)
	
	# Emit signal for UI updates
	rhythm_hit.emit(judgment.result, groove_reward, timing_offset_ms)

func calculate_groove_reward(base_score: int) -> int:
	if base_score == 0:
		return 0
	
	# Base groove reward
	var reward = base_score
	
	# Combo bonus - every 5 hits in a row gives bonus
	var combo_bonus = combo_count / 5
	reward += combo_bonus
	
	return reward

func _on_hit_judged(result: InputJudge.HitResult, timing_offset: float, score: int):
	# This is called by InputJudge when judgment is complete
	pass

func get_accuracy_percentage() -> float:
	if total_hits == 0:
		return 0.0
	
	var accurate_hits = perfect_hits + good_hits
	return (float(accurate_hits) / float(total_hits)) * 100.0

func get_stats() -> Dictionary:
	return {
		"total_hits": total_hits,
		"perfect_hits": perfect_hits,
		"good_hits": good_hits,
		"missed_hits": missed_hits,
		"combo_count": combo_count,
		"accuracy": get_accuracy_percentage()
	}

func reset_stats():
	total_hits = 0
	perfect_hits = 0
	good_hits = 0
	missed_hits = 0
	combo_count = 0