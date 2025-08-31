extends Node

# Currency system for Groove points
# Singleton - add to Project Settings > Autoload

signal groove_changed(new_amount: int)
signal passive_income_changed(new_rate: float)

var groove: int = 0
var passive_income_sources: Dictionary = {}  # id -> rate mapping
var passive_timer: Timer

func _ready():
	# Initialize with starting amount
	set_groove(0)
	
	# Setup passive income timer
	setup_passive_income_timer()

func add_groove(amount: int):
	if amount > 0:
		groove += amount
		groove_changed.emit(groove)

func spend_groove(amount: int) -> bool:
	if groove >= amount:
		groove -= amount
		groove_changed.emit(groove)
		return true
	return false

func set_groove(amount: int):
	groove = max(0, amount)  # Ensure groove never goes negative
	groove_changed.emit(groove)

func get_groove() -> int:
	return groove

func can_afford(cost: int) -> bool:
	return groove >= cost

func setup_passive_income_timer():
	passive_timer = Timer.new()
	add_child(passive_timer)
	passive_timer.timeout.connect(_on_passive_income_tick)
	passive_timer.wait_time = 1.0  # Generate income every second
	passive_timer.autostart = true
	passive_timer.start()

func add_passive_income_source(source_id: String, groove_per_second: float):
	passive_income_sources[source_id] = groove_per_second
	var total_rate = get_total_passive_income_rate()
	passive_income_changed.emit(total_rate)
	print("Added passive income source: ", source_id, " at ", groove_per_second, " Groove/sec")

func remove_passive_income_source(source_id: String):
	if passive_income_sources.has(source_id):
		passive_income_sources.erase(source_id)
		var total_rate = get_total_passive_income_rate()
		passive_income_changed.emit(total_rate)

func get_total_passive_income_rate() -> float:
	var total = 0.0
	for rate in passive_income_sources.values():
		total += rate
	return total

func _on_passive_income_tick():
	var total_rate = get_total_passive_income_rate()
	if total_rate > 0:
		var passive_groove = int(ceil(total_rate))  # Convert to int, round up
		add_groove(passive_groove)

# For future save/load system
func get_save_data() -> Dictionary:
	return {
		"groove": groove,
		"passive_income_sources": passive_income_sources
	}

func load_save_data(data: Dictionary):
	if data.has("groove"):
		set_groove(data.groove)
	if data.has("passive_income_sources"):
		passive_income_sources = data.passive_income_sources
		var total_rate = get_total_passive_income_rate()
		passive_income_changed.emit(total_rate)