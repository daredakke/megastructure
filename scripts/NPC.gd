class_name Npc
extends StaticBody3D
## Provides a reference to a piece of dialogue. Can be set as a dev commentary
## node that can have its visibility toggled.


@export var dialogue_index: Dialogue.Keys
@export var is_commentary: bool = false


func _ready() -> void:
	if not is_commentary: return
	
	EventsBus.toggle_commentary.connect(_toggle_visibility)
	
	_toggle_visibility()


## Toggles visibility of dev commentary nodes.
func _toggle_visibility() -> void:
	if Globals.commentary_enabled:
		show()
		
		for node in get_children():
			if node is CollisionShape3D:
				node.disabled = false
	else:
		hide()
		
		for node in get_children():
			if node is CollisionShape3D:
				node.disabled = true
