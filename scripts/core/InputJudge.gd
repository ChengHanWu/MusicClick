extends Node

# Input timing judgment system
# Determines accuracy of player input relative to beat timing

enum HitResult {
	MISS,
	GOOD,
	PERFECT
}

# Timing windows in milliseconds - reasonable values 
const PERFECT_WINDOW_MS = 50.0   # Perfect window: ≤50ms
const GOOD_WINDOW_MS = 150.0     # Good window: 50-150ms

# Scoring system
const PERFECT_SCORE: int = 3
const GOOD_SCORE: int = 1
const MISS_SCORE: int = 0

signal hit_judged(result: HitResult, timing_offset: float, score: int)

func judge_input_timing(timing_offset: float) -> Dictionary:
	var abs_offset = abs(timing_offset * 1000.0)  # Convert to milliseconds
	var result: HitResult
	var score: int
	
	if abs_offset <= PERFECT_WINDOW_MS:
		result = HitResult.PERFECT
		score = PERFECT_SCORE
	elif abs_offset <= GOOD_WINDOW_MS:
		result = HitResult.GOOD
		score = GOOD_SCORE
	else:
		result = HitResult.MISS
		score = MISS_SCORE
	
	var judgment = {
		"result": result,
		"timing_offset": timing_offset,
		"score": score,
		"abs_offset_ms": abs_offset
	}
	
	hit_judged.emit(result, timing_offset, score)
	return judgment

func get_result_string(result: HitResult) -> String:
	match result:
		HitResult.PERFECT:
			return "PERFECT!"
		HitResult.GOOD:
			return "Good"
		HitResult.MISS:
			return "Miss"
		_:
			return "Unknown"

func get_result_color(result: HitResult) -> Color:
	match result:
		HitResult.PERFECT:
			return Color.GOLD
		HitResult.GOOD:
			return Color.GREEN
		HitResult.MISS:
			return Color.RED
		_:
			return Color.WHITE

# Helper function to check if player is within any timing window
func is_in_timing_window(timing_offset: float) -> bool:
	var abs_offset = abs(timing_offset * 1000.0)
	return abs_offset <= GOOD_WINDOW_MS