class_name SpeechBubble
extends MeshInstance3D
## For making dev commentary nodes that spin around slowly.


func _physics_process(delta: float) -> void:
	rotate_y(0.9 * delta)
