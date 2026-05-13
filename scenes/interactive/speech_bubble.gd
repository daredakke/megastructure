class_name SpeechBubble
extends MeshInstance3D

func _physics_process(delta: float) -> void:
	rotate_y(0.9 * delta)
