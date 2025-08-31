extends Node

# HUD Controller for managing UI updates and displays

@onready var groove_counter: Label
@onready var hit_feedback: Label
@onready var rhythm_circle: Button
@onready var circle_visual: Panel
@onready var circle_animation: AnimationPlayer
@onready var passive_income_label: Label
@onready var shop_panel: Panel
@onready var drum_machine_buy_button: Button
@onready var drum_machine_status: Label
@onready var shop_passive_income_label: Label

var currency_manager: Node
var metronome: Node
var shop_manager: Node
var tween: Tween

func _ready():
	# Wait for scene to be fully ready
	await get_tree().process_frame
	
	# Get UI references from the main scene
	var main_scene = get_tree().current_scene
	groove_counter = main_scene.get_node("UI/TopUI/GrooveCounter")
	hit_feedback = main_scene.get_node("UI/TopUI/HitFeedback")
	passive_income_label = main_scene.get_node("UI/TopUI/PassiveIncome")
	rhythm_circle = main_scene.get_node("UI/CenterContainer/RhythmCircle")
	circle_visual = main_scene.get_node("UI/CenterContainer/RhythmCircle/CircleVisual")
	circle_animation = main_scene.get_node("UI/CenterContainer/RhythmCircle/CircleAnimation")
	
	# Get shop UI references
	shop_panel = main_scene.get_node("UI/Shop")
	drum_machine_buy_button = main_scene.get_node("UI/Shop/VBoxContainer/InstrumentList/DrumMachineItem/DrumMachineBuyButton")
	drum_machine_status = main_scene.get_node("UI/Shop/VBoxContainer/InstrumentList/DrumMachineItem/DrumMachineStatus")
	shop_passive_income_label = main_scene.get_node("UI/Shop/VBoxContainer/PassiveIncomeLabel")
	
	# Get singleton references
	currency_manager = CurrencyManager
	metronome = Metronome
	shop_manager = ShopManager
	
	# Connect signals
	currency_manager.groove_changed.connect(_on_groove_changed)
	currency_manager.passive_income_changed.connect(_on_passive_income_changed)
	metronome.beat_pulse.connect(_on_beat_pulse)
	
	# Connect shop signals
	if drum_machine_buy_button:
		drum_machine_buy_button.pressed.connect(_on_drum_machine_buy_pressed)
	if shop_manager:
		shop_manager.instrument_purchased.connect(_on_instrument_purchased)
		shop_manager.purchase_failed.connect(_on_purchase_failed)
	
	# Initialize display
	_on_groove_changed(currency_manager.get_groove())
	_on_passive_income_changed(currency_manager.get_total_passive_income_rate())
	update_shop_display()

func _on_groove_changed(new_amount: int):
	if groove_counter:
		groove_counter.text = "Groove: " + str(new_amount)
	
	# Update shop display when groove changes
	update_shop_display()

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

func _on_passive_income_changed(new_rate: float):
	if passive_income_label:
		passive_income_label.text = "Passive: %.1f Groove/sec" % new_rate
	if shop_passive_income_label:
		shop_passive_income_label.text = "Passive Income: %.1f Groove/sec" % new_rate

func _on_drum_machine_buy_pressed():
	if shop_manager:
		shop_manager.purchase_instrument("drum_machine")

func _on_instrument_purchased(instrument_id: String, instrument: Instrument):
	print("Successfully purchased: ", instrument.get_display_name())
	update_shop_display()

func _on_purchase_failed(reason: String):
	print("Purchase failed: ", reason)
	if drum_machine_status:
		drum_machine_status.text = "❌ " + reason
		# Clear the error message after a delay
		await get_tree().create_timer(3.0).timeout
		update_shop_display()

func update_shop_display():
	if not shop_manager:
		return
		
	# Update drum machine button state
	if drum_machine_buy_button and drum_machine_status:
		var owns_drum = shop_manager.owns_instrument("drum_machine")
		var can_afford = shop_manager.can_purchase_instrument("drum_machine")
		
		if owns_drum:
			drum_machine_buy_button.disabled = true
			drum_machine_buy_button.text = "OWNED"
			drum_machine_status.text = "✅ Generating passive income!"
		elif can_afford:
			drum_machine_buy_button.disabled = false
			drum_machine_buy_button.text = "BUY DRUM MACHINE"
			drum_machine_status.text = "Ready to purchase"
		else:
			drum_machine_buy_button.disabled = true
			drum_machine_buy_button.text = "NOT ENOUGH GROOVE"
			var available_data = shop_manager.get_available_instruments()
			if available_data.has("drum_machine"):
				var cost = available_data["drum_machine"].cost
				var current = currency_manager.get_groove()
				drum_machine_status.text = "Need %d more Groove (%d/%d)" % [cost - current, current, cost]