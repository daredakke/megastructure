class_name Atmospherics
extends AudioStreamPlayer


const DEFAULT_BUS: String = "Atmospherics"

@export var default_volume: float = -15.0
@export var default_pitch: float = 0.95
## Upper bound for low pass cutoff frequency.
@export var max_hz: int = 2000
## Lower bound for low pass cutoff frequency.
@export var min_hz: int = 500


func _ready() -> void:
	EventsBus.player_space_openness.connect(update_atmospherics_low_pass)
	finished.connect(_on_finished)
	bus = DEFAULT_BUS
	volume_db = default_volume
	pitch_scale = default_pitch
	play()


func _exit_tree() -> void:
	stop()


func _on_finished() -> void:
	play()


## Dull atmospherics when in less open environments.
func update_atmospherics_low_pass(openness: float) -> void:
	var new_hz := ((max_hz - min_hz) * openness) + min_hz
	AudioServer.get_bus_effect(AudioServer.get_bus_index(DEFAULT_BUS), 1).cutoff_hz = new_hz
