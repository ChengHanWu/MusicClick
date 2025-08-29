extends Node

# Global metronome system for precise timing
# Singleton - add to Project Settings > Autoload

signal beat_pulse  # Emitted on each beat
signal measure_complete  # Emitted every 4 beats

var bpm: float = 90.0  # Beats per minute
var is_playing: bool = false
var beat_count: int = 0
var time_per_beat: float
var time_since_last_beat: float = 0.0

# Timing precision
var current_beat_time: float = 0.0

func _ready():
	calculate_timing()
	start()

func calculate_timing():
	# Convert BPM to seconds per beat
	time_per_beat = 60.0 / bpm

func start():
	is_playing = true
	beat_count = 0
	time_since_last_beat = 0.0

func stop():
	is_playing = false

func set_bpm(new_bpm: float):
	bpm = new_bpm
	calculate_timing()

func _process(delta):
	if not is_playing:
		return
		
	time_since_last_beat += delta
	
	# Check if it's time for the next beat
	if time_since_last_beat >= time_per_beat:
		emit_beat()
		time_since_last_beat = 0.0
		beat_count += 1
		
		# Every 4 beats is a measure in 4/4 time
		if beat_count % 4 == 0:
			measure_complete.emit()

func emit_beat():
	# Use Time.get_time_dict_from_system() correctly - no millisecond key exists
	var time_dict = Time.get_time_dict_from_system()
	current_beat_time = time_dict["hour"] * 3600.0 + \
					   time_dict["minute"] * 60.0 + \
					   time_dict["second"]
	beat_pulse.emit()

# Get the current time within the beat cycle (0.0 to 1.0)
func get_beat_progress() -> float:
	if time_per_beat == 0:
		return 0.0
	return time_since_last_beat / time_per_beat

# Get time until next beat in seconds
func get_time_to_next_beat() -> float:
	return time_per_beat - time_since_last_beat

# Check if current time is close to a beat (for input timing)
func is_near_beat(tolerance_ms: float = 50.0) -> float:
	var tolerance_seconds = tolerance_ms / 1000.0
	var time_to_beat = get_time_to_next_beat()
	var time_from_last_beat = time_since_last_beat
	
	# Check if we're within tolerance of the next beat
	if time_to_beat <= tolerance_seconds:
		return time_to_beat * 1000.0  # Convert back to milliseconds
	
	# Check if we're within tolerance of the last beat
	if time_from_last_beat <= tolerance_seconds:
		return -time_from_last_beat * 1000.0  # Convert back to milliseconds
	
	# Not near any beat
	return 999.0  # Return large number to indicate miss
