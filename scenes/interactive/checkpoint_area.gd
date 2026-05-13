class_name CheckpointArea
extends Area3D


@onready var respawn_point: Marker3D = $RespawnPoint


func get_respawn_point() -> Vector3:
	return respawn_point.global_position


func _on_body_entered(body: Node3D) -> void:
	if body is FpsController:
		body.respawn_position = respawn_point.global_position
		body.respawn_orientation = respawn_point.global_rotation
