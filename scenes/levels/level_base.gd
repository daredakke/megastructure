class_name LevelBase
extends Node3D

const FPS_CONTROLLER = preload("uid://ct1rg4grgbrd6")

@onready var spawn_points: Node3D = $SpawnPoints


func spawn_player(spawn_point_name: String, _torch_is_on: bool) -> void:
	var spawn_point = null
	
	for child in spawn_points.get_children():
		if spawn_point_name == child.name:
			spawn_point = child
	
	if spawn_point == null:
		print("Can't find spawn point '", spawn_point_name, "', falling back to first child")
		spawn_point = spawn_points.get_children()[0]
	
	var player = FPS_CONTROLLER.instantiate()
	
	add_child(player)
	
	if _torch_is_on:
		player.show_torch()
	
	player.global_position = spawn_point.global_position
	player.global_rotation = spawn_point.global_rotation
	player.respawn_position = spawn_point.global_position
	player.respawn_orientation = spawn_point.global_rotation
