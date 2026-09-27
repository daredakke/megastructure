class_name DoubleDoors
extends Node3D


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_detection_area_body_entered(body: Node3D) -> void:
	# Only open for the player if door is unlocked
	if body is FpsController:
		animation_player.play("open")


func _on_detection_area_body_exited(body: Node3D) -> void:
	if body is FpsController:
		animation_player.play_backwards("open")
