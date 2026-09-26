@tool
class_name Pictures
extends Node3D


@export_tool_button("Generate Picture Frames") var generate_button := generate_picture_frames


func generate_picture_frames() -> void:
	for node in get_children():
		if node is WallSprite:
			node.generate_picture_frame()
