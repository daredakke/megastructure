class_name ClimbingArea
extends Area3D


@onready var marker_3d: Marker3D = $Marker3D


func _on_body_entered(body: Node3D) -> void:
	if body is FpsController:
		var pos := Vector2(marker_3d.global_position.x, marker_3d.global_position.z)
		
		EventsBus.player_touched_ladder.emit(pos, $CollisionShape3D.shape.size.y, marker_3d.global_position.y, marker_3d.global_transform.basis.z)
