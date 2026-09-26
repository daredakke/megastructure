class_name CourtyardBenches
extends Node3D


func _ready() -> void:
	for node in get_children():
		var target := Vector3.ZERO
		target.y = global_position.y

		node.look_at(target)
