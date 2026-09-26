@tool
class_name WallAnimation
extends AnimatedSprite3D


const RAY_LENGTH := 1000.0

@export_tool_button("Place Against Wall") var place_button := place_against_surface
@export_tool_button("Undo Last Move") var undo_button := undo_action

@onready var _last_pos := global_position


func place_against_surface() -> void:
	var ray_end = global_position - global_basis.z * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(global_position, ray_end)
	var result = get_world_3d().direct_space_state.intersect_ray(query)

	if result:
		var new_pos = result.position + result.normal * 0.01
		
		# Only update last stored position if the node has to move
		if new_pos != global_position:
			_last_pos = global_position
			global_position = new_pos

		# Rotate the node so its back (-z) faces the surface normal
		look_at(result.position + result.normal, Vector3.UP)
		rotate_y(TAU * 0.5)


func undo_action() -> void:
	global_position = _last_pos
