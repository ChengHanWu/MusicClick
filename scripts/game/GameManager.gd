extends Node2D

# Main game manager - coordinates all systems and handles game flow

@onready var rhythm_controller: Node
@onready var hud_controller: Node
@onready var rhythm_circle: Button

var metronome: Node
var currency_manager: Node
var is_game_active: bool = false

func _ready():
	# Get singleton references
	metronome = Metronome
	currency_manager = CurrencyManager
	
	# Create and add rhythm controller
	rhythm_controller = preload("res://scripts/game/RhythmController.gd").new()
	add_child(rhythm_controller)
	
	# Create and add HUD controller
	hud_controller = preload("res://scripts/ui/HUDController.gd").new()
	add_child(hud_controller)
	
	# Wait for scene to be ready
	await get_tree().process_frame
	
	# Get UI references
	rhythm_circle = get_node("UI/CenterContainer/RhythmCircle")
	
	# Connect signals
	if rhythm_circle:
		rhythm_circle.pressed.connect(_on_rhythm_circle_pressed)
		print("Circle button connected successfully!")
	else:
		print("ERROR: Could not find rhythm circle!")
		
	if rhythm_controller:
		rhythm_controller.rhythm_hit.connect(_on_rhythm_hit)
		print("Rhythm controller connected successfully!")
	
	# Start the game
	start_game()

func start_game():
	is_game_active = true
	
	# Activate all systems
	if metronome:
		metronome.start()
		
	if rhythm_controller:
		rhythm_controller.activate()
	
	print("Game started! Click the circle when it pulses!")

func stop_game():
	is_game_active = false
	
	if metronome:
		metronome.stop()
		
	if rhythm_controller:
		rhythm_controller.deactivate()

func _on_rhythm_circle_pressed():
	if not is_game_active:
		return
		
	# Handle the rhythm input
	if rhythm_controller:
		rhythm_controller.handle_rhythm_input()

func _on_rhythm_hit(result: InputJudge.HitResult, score: int, timing_offset: float):
	# Update HUD with hit feedback
	if hud_controller:
		hud_controller.show_hit_feedback(result, score)
		hud_controller.animate_hit_response(result)

func get_game_stats() -> Dictionary:
	if rhythm_controller:
		return rhythm_controller.get_stats()
	return {}

func reset_game():
	if rhythm_controller:
		rhythm_controller.reset_stats()
	
	if currency_manager:
		currency_manager.set_groove(0)

# Debug function to check progress toward success criteria
func check_groove_rate():
	var current_groove = currency_manager.get_groove()
	print("Current Groove: ", current_groove)
	
	# Check if we're meeting the 100+ Groove in 30 seconds target
	# This would need to be called after 30 seconds of gameplay
	if current_groove >= 100:
		print("SUCCESS: Achieved 100+ Groove!")
	else:
		print("Target: ", current_groove, "/100 Groove")

func _input(event):
	# Debug keys
	if event.is_action_pressed("ui_accept"):  # Space key
		check_groove_rate()
	elif event.is_action_pressed("ui_cancel"):  # Escape key
		reset_game()
	
	# Fallback click detection - detect any mouse click (remove when button works properly)
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Check if click is roughly in the center area
		var screen_size = get_viewport().get_visible_rect().size
		var center = screen_size / 2
		var distance_from_center = event.position.distance_to(center)
		
		# If click is within 150 pixels of center, treat as rhythm input
		if distance_from_center <= 150:
			_on_rhythm_circle_pressed()
