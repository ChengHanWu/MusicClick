extends Node

# HUD Controller for managing UI updates and displays

@onready var groove_counter: Label
@onready var hit_feedback: Label
@onready var rhythm_circle: Button
@onready var circle_visual: Panel
@onready var circle_animation: AnimationPlayer

var currency_manager: Node
var metronome: Node
var tween: Tween

func _ready():
	# Wait for scene to be fully ready
	await get_tree().process_frame
	
	# Get UI references from the main scene
	var main_scene = get_tree().current_scene
	groove_counter = main_scene.get_node("UI/TopUI/GrooveCounter")
	hit_feedback = main_scene.get_node("UI/TopUI/HitFeedback")
	rhythm_circle = main_scene.get_node("UI/CenterContainer/RhythmCircle")
	circle_visual = main_scene.get_node("UI/CenterContainer/RhythmCircle/CircleVisual")
	circle_animation = main_scene.get_node("UI/CenterContainer/RhythmCircle/CircleAnimation")
	
	# Get singleton references
	currency_manager = CurrencyManager
	metronome = Metronome
	
	# Connect signals
	currency_manager.groove_changed.connect(_on_groove_changed)
	metronome.beat_pulse.connect(_on_beat_pulse)
	
	# Initialize display
	_on_groove_changed(currency_manager.get_groove())

func _on_groove_changed(new_amount: int):
	if groove_counter:
		groove_counter.text = "Groove: " + str(new_amount)

func show_hit_feedback(result: InputJudge.HitResult, score: int):
	if not hit_feedback:
		return
		
	var feedback_text = ""
	var feedback_color = Color.WHITE
	
	match result:
		InputJudge.HitResult.PERFECT:
			feedback_text = "PERFECT! +" + str(score)
			feedback_color = Color.GOLD
		InputJudge.HitResult.GOOD:
			feedback_text = "Good +" + str(score)
			feedback_color = Color.GREEN
		InputJudge.HitResult.MISS:
			feedback_text = "Miss"
			feedback_color = Color.RED
	
	hit_feedback.text = feedback_text
	hit_feedback.modulate = feedback_color
	
	# Animate feedback text
	animate_feedback_text()

func animate_feedback_text():
	if not hit_feedback:
		return
		
	# Stop any existing tween
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.set_parallel(true)
	
	# Scale animation
	hit_feedback.scale = Vector2(1.5, 1.5)
	tween.tween_property(hit_feedback, "scale", Vector2.ONE, 0.3)
	
	# Fade out after delay
	tween.tween_property(hit_feedback, "modulate:a", 0.0, 0.5).set_delay(1.0)
	tween.tween_callback(func(): hit_feedback.text = "").set_delay(1.5)

func _on_beat_pulse():
	animate_circle_pulse()

func animate_circle_pulse():
	if not circle_visual:
		return
		
	# Set pivot to center for proper scaling
	circle_visual.pivot_offset = circle_visual.size / 2
	
	# Create pulse animation
	var pulse_tween = create_tween()
	pulse_tween.set_parallel(true)
	
	# Scale pulse from center
	circle_visual.scale = Vector2(1.2, 1.2)
	pulse_tween.tween_property(circle_visual, "scale", Vector2.ONE, 0.2)
	
	# Modulate pulse - brighter on beat
	circle_visual.modulate = Color(1.5, 1.5, 1.5, 1.0)
	pulse_tween.tween_property(circle_visual, "modulate", Color.WHITE, 0.3)

func animate_hit_response(result: InputJudge.HitResult):
	if not circle_visual:
		return
		
	# Ensure pivot is centered for hit animations too
	circle_visual.pivot_offset = circle_visual.size / 2
		
	var response_tween = create_tween()
	
	match result:
		InputJudge.HitResult.PERFECT:
			# Gold flash for perfect
			circle_visual.modulate = Color.GOLD
			response_tween.tween_property(circle_visual, "modulate", Color.WHITE, 0.2)
		InputJudge.HitResult.GOOD:
			# Green flash for good
			circle_visual.modulate = Color.GREEN
			response_tween.tween_property(circle_visual, "modulate", Color.WHITE, 0.2)
		InputJudge.HitResult.MISS:
			# Red flash for miss
			circle_visual.modulate = Color.RED
			response_tween.tween_property(circle_visual, "modulate", Color.WHITE, 0.2)