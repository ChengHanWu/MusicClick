extends Node

# Currency system for Groove points
# Singleton - add to Project Settings > Autoload

signal groove_changed(new_amount: int)

var groove: int = 0

func _ready():
	# Initialize with starting amount
	set_groove(0)

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

# For future save/load system
func get_save_data() -> Dictionary:
	return {
		"groove": groove
	}

func load_save_data(data: Dictionary):
	if data.has("groove"):
		set_groove(data.groove)