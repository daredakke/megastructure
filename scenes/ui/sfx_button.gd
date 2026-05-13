class_name SfxButton
extends Button


var branch_name: String = ""


func _ready() -> void:
	mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND

	pressed.connect(_on_pressed)
	mouse_entered.connect(_on_mouse_entered)


func _on_mouse_entered() -> void:
	if not disabled:
		EventsBus.button_hovered.emit()


func _on_pressed() -> void:
	if not disabled:
		EventsBus.button_pressed.emit()
	
	if branch_name != "":
		EventsBus.choice_made.emit(branch_name)
