class_name SceneChangerArea
extends Area3D
## Level change trigger area. Can define the scene to move to and spawn
## point to place the player at.


@export var next_scene: LevelConfig.Keys
@export var next_spawn: String = "Start"


func _on_body_entered(body: Node3D) -> void:
	# Change to a different level if the player enters this area
	if body is FpsController:
		EventsBus.scene_changed.emit(next_scene, next_spawn, body.is_torch_visible())
