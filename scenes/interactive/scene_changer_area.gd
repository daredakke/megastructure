class_name SceneChangerArea
extends Area3D


@export var next_scene: LevelConfig.Keys
@export var next_spawn: String = "Start"


func _on_body_entered(body: Node3D) -> void:
	if body is FpsController:
		EventsBus.scene_changed.emit(next_scene, next_spawn, body.get_torch_status())
