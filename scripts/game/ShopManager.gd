extends Node

# Shop system for purchasing instruments
# Singleton - add to Project Settings > Autoload

signal instrument_purchased(instrument_id: String, instrument: Instrument)
signal purchase_failed(reason: String)

var owned_instruments: Array[Instrument] = []
var available_instruments: Dictionary = {}

func _ready():
	setup_available_instruments()

func setup_available_instruments():
	# Define available instruments for purchase
	available_instruments = {
		"drum_machine": {
			"name": "Drum Machine",
			"description": "A simple drum machine that generates steady Groove",
			"cost": 150,
			"groove_per_second": 1.5,
			"icon": "res://assets/ui/drum_icon.png"  # placeholder path
		}
	}

func can_purchase_instrument(instrument_id: String) -> bool:
	if not available_instruments.has(instrument_id):
		return false
	
	var cost = available_instruments[instrument_id].cost
	return CurrencyManager.can_afford(cost)

func purchase_instrument(instrument_id: String) -> bool:
	if not available_instruments.has(instrument_id):
		purchase_failed.emit("Instrument not found")
		return false
	
	var instrument_data = available_instruments[instrument_id]
	var cost = instrument_data.cost
	
	if not CurrencyManager.can_afford(cost):
		purchase_failed.emit("Not enough Groove")
		return false
	
	# Deduct cost
	if not CurrencyManager.spend_groove(cost):
		purchase_failed.emit("Purchase failed")
		return false
	
	# Create and add instrument
	var instrument = create_instrument(instrument_id, instrument_data)
	owned_instruments.append(instrument)
	
	# Enable passive income
	CurrencyManager.add_passive_income_source(instrument_id, instrument_data.groove_per_second)
	
	instrument_purchased.emit(instrument_id, instrument)
	print("Purchased ", instrument_data.name, " for ", cost, " Groove!")
	return true

func create_instrument(instrument_id: String, data: Dictionary) -> Instrument:
	var instrument: Instrument
	
	match instrument_id:
		"drum_machine":
			instrument = preload("res://scripts/instruments/DrumMachine.gd").new()
		_:
			# Default to basic instrument
			instrument = preload("res://scripts/instruments/Instrument.gd").new()
	
	instrument.setup(instrument_id, data.name, data.groove_per_second)
	return instrument

func get_owned_instruments() -> Array[Instrument]:
	return owned_instruments

func get_available_instruments() -> Dictionary:
	return available_instruments

func owns_instrument(instrument_id: String) -> bool:
	for instrument in owned_instruments:
		if instrument.id == instrument_id:
			return true
	return false

func get_total_passive_income() -> float:
	var total = 0.0
	for instrument in owned_instruments:
		total += instrument.groove_per_second
	return total

# For save/load system
func get_save_data() -> Dictionary:
	var instruments_data = []
	for instrument in owned_instruments:
		instruments_data.append(instrument.get_save_data())
	
	return {
		"owned_instruments": instruments_data
	}

func load_save_data(data: Dictionary):
	owned_instruments.clear()
	
	if data.has("owned_instruments"):
		for instrument_data in data.owned_instruments:
			var instrument = create_instrument(instrument_data.id, instrument_data)
			instrument.load_save_data(instrument_data)
			owned_instruments.append(instrument)
			
			# Re-enable passive income
			CurrencyManager.add_passive_income_source(instrument.id, instrument.groove_per_second)
