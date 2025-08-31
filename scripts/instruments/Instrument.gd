extends Resource
class_name Instrument

# Base class for all purchasable instruments

var id: String = ""
var name: String = ""
var groove_per_second: float = 0.0
var purchase_time: float = 0.0
var is_active: bool = true

func setup(instrument_id: String, instrument_name: String, passive_rate: float):
	id = instrument_id
	name = instrument_name
	groove_per_second = passive_rate
	purchase_time = Time.get_ticks_msec() / 1000.0
	is_active = true

func get_display_name() -> String:
	return name

func get_passive_rate() -> float:
	return groove_per_second if is_active else 0.0

func set_active(active: bool):
	is_active = active

func get_description() -> String:
	return "Generates %.1f Groove per second" % groove_per_second

func get_icon_path() -> String:
	# Override in subclasses for specific icons
	return "res://assets/ui/default_instrument_icon.png"

# Virtual method - override in subclasses for specific audio behavior
func play_sound():
	pass

# Virtual method - override for special effects when activated
func on_activate():
	pass

# Virtual method - override for cleanup when deactivated  
func on_deactivate():
	pass

# Save/load functionality
func get_save_data() -> Dictionary:
	return {
		"id": id,
		"name": name,
		"groove_per_second": groove_per_second,
		"purchase_time": purchase_time,
		"is_active": is_active
	}

func load_save_data(data: Dictionary):
	if data.has("id"): id = data.id
	if data.has("name"): name = data.name
	if data.has("groove_per_second"): groove_per_second = data.groove_per_second
	if data.has("purchase_time"): purchase_time = data.purchase_time
	if data.has("is_active"): is_active = data.is_active