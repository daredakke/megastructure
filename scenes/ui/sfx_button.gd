class_name SfxButton
extends Button


var branch_name: String = ""

@export var is_tab_button: bool = false
@export var is_active: bool = false


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
	
		if is_tab_button and not is_active:
			EventsBus.tab_button_pressed.emit(name)
	
	if branch_name != "":
		EventsBus.choice_made.emit(branch_name)
