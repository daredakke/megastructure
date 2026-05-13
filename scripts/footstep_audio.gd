class_name FootstepAudio
extends AudioStreamPlayer


const PAN := 0.1

@export var material: MaterialConfig.Keys
@export var volume_reduction := 0.1
@export var pitch_reduction := 0.1
@export var right_foot_boost := 0.09
@export var landing_boost_db := 4.0

var _right_foot := false

@onready var _original_volume := db_to_linear(volume_db)
@onready var _original_pitch_scale := pitch_scale


func _change_foot() -> void:
	_right_foot = !_right_foot

	if _right_foot:
		AudioServer.get_bus_effect(AudioServer.get_bus_index("Footsteps"), 0).pan = -PAN
		return

	AudioServer.get_bus_effect(AudioServer.get_bus_index("Footsteps"), 0).pan = PAN


func modulate_pitch(is_landing: bool) -> void:
	_change_foot()

	var new_volume := linear_to_db(randf_range(_original_volume - volume_reduction, _original_volume))
	new_volume += landing_boost_db if is_landing else 0.0
	volume_db = new_volume

	var new_pitch := randf_range(_original_pitch_scale - pitch_reduction, _original_pitch_scale)
	new_pitch += right_foot_boost if _right_foot else 0.0
	pitch_scale = new_pitch
