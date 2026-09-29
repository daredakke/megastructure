class_name DoubleDoors
extends Node3D


const ANIM_DURATION: float = 0.4

var _elapsed_time: float = 0.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sfx: AudioStreamPlayer = $Sfx


func _physics_process(_delta: float) -> void:
	if animation_player.is_playing():
		_elapsed_time += 0.016


func _on_detection_area_body_entered(body: Node3D) -> void:
	if body is FpsController:
		animation_player.play("open")
		_play_door_sfx()


func _on_detection_area_body_exited(body: Node3D) -> void:
	if body is FpsController:
		animation_player.play_backwards("open")
		_play_door_sfx()


## Ensure door SFX takes into account animation play time
func _play_door_sfx() -> void:
	if _elapsed_time == 0.0:
		sfx.play()
	else:
		sfx.play(ANIM_DURATION - _elapsed_time)


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	_elapsed_time = 0.0
