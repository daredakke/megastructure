class_name FootstepController
extends Node


func _get_footstep_audio_player(material: MaterialConfig.Keys) -> AudioStreamPlayer:
	for child in get_children():
		if "material" in child and material == child.material:
			return child

	# Default footstep sound
	return get_children()[0]


func play_footstep(material: MaterialConfig.Keys, is_landing: bool) -> void:
	var player = _get_footstep_audio_player(material)
	player.modulate_pitch(is_landing)
	player.play()
