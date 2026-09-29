class_name FootstepController
extends Node


var _concrete_sfx: Array[AudioStreamPlayer]
var _metal_dull_sfx: Array[AudioStreamPlayer]
var _metal_hollow_sfx: Array[AudioStreamPlayer]
var _previous_footstep: int = 1

@onready var concrete: Node = $Concrete
@onready var metal_dull: Node = $MetalDull
@onready var metal_hollow: Node = $MetalHollow


func _ready() -> void:
	for node in concrete.get_children():
		_concrete_sfx.push_back(node)
		
	for node in metal_dull.get_children():
		_metal_dull_sfx.push_back(node)
	
	for node in metal_hollow.get_children():
		_metal_hollow_sfx.push_back(node)


func _get_footstep_audio_player(material: MaterialConfig.Keys) -> AudioStreamPlayer:
	var audio_player: AudioStreamPlayer
	var new_index: int
	
	match material:
		MaterialConfig.Keys.MetalDull:
			new_index = _get_different_index(9)
			audio_player = _metal_dull_sfx[new_index]
		
		MaterialConfig.Keys.MetalHollow:
			new_index = _get_different_index(8)
			audio_player = _metal_hollow_sfx[new_index]
		
		MaterialConfig.Keys.Concrete, _:
			new_index = _get_different_index(9)
			audio_player = _concrete_sfx[new_index]
			
	_previous_footstep = new_index
	return audio_player


func _get_different_index(max: int) -> int:
	if _previous_footstep > max:
		return randi_range(0, max)
	
	var choice: int = _previous_footstep
	
	while choice == _previous_footstep:
		choice = randi_range(0, max)
	
	return choice


## Play a footstep sound effect for a given material.
func play_footstep(material: MaterialConfig.Keys, is_landing: bool) -> void:
	var player = _get_footstep_audio_player(material)
	player.modulate_pitch(is_landing)
	player.play()
