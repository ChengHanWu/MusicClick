extends Instrument
class_name DrumMachine

# Drum Machine instrument - generates steady rhythm and passive Groove

var drum_audio_player: AudioStreamPlayer
var drum_timer: Timer
var drum_sounds: Array[AudioStream] = []

func _init():
	# Setup will be called after creation to initialize properties
	pass

func setup(instrument_id: String, instrument_name: String, passive_rate: float):
	super.setup(instrument_id, instrument_name, passive_rate)
	load_drum_sounds()
	setup_audio_player()
	setup_drum_timer()

func load_drum_sounds():
	# Load drum sound files from audio/instruments/drums/
	var kick_path = "res://audio/instruments/drums/kick.ogg"
	var snare_path = "res://audio/instruments/drums/snare.ogg"
	var hihat_path = "res://audio/instruments/drums/hihat.ogg"
	
	# For now, we'll use placeholder paths - sounds will be added later
	# drum_sounds will remain empty until audio files are added
	pass

func setup_audio_player():
	drum_audio_player = AudioStreamPlayer.new()
	drum_audio_player.volume_db = -10.0  # Quieter than main rhythm sounds
	
func setup_drum_timer():
	drum_timer = Timer.new()
	drum_timer.timeout.connect(_on_drum_beat)
	drum_timer.wait_time = 60.0 / 90.0  # 90 BPM to match main rhythm
	drum_timer.autostart = false

func get_icon_path() -> String:
	return "res://assets/ui/drum_machine_icon.png"

func get_description() -> String:
	return "Steady drum beats + %.1f Groove/sec" % groove_per_second

func on_activate():
	if drum_timer and is_active:
		drum_timer.start()
		print("Drum machine activated - generating passive income")

func on_deactivate():
	if drum_timer:
		drum_timer.stop()

func play_sound():
	if drum_sounds.size() > 0 and drum_audio_player:
		# Play a random drum sound
		var random_sound = drum_sounds[randi() % drum_sounds.size()]
		drum_audio_player.stream = random_sound
		drum_audio_player.play()

func _on_drum_beat():
	if is_active:
		# Play drum sound if available
		play_sound()

func set_active(active: bool):
	super.set_active(active)
	
	if active:
		on_activate()
	else:
		on_deactivate()