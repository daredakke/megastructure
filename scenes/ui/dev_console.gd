class_name DevConsole
extends Control


var _previous_input: Array[String] = []
var _previous_index: int = 0

@onready var console_input: LineEdit = $PanelContainer/ConsoleInput
@onready var output_v_box: VBoxContainer = $MarginContainer/OutputVBox


func _ready() -> void:
	EventsBus.game_paused.connect(_regain_focus_after_pause)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("dev"):
		_toggle_dev_console()
	
	if Input.is_action_just_pressed("ui_up") and visible:
		_previous_index -= 1
		
		if abs(_previous_index) > _previous_input.size():
			_previous_index = -_previous_input.size()
		
		_insert_previous_input()
	
	if Input.is_action_just_pressed("ui_down") and visible:
		_previous_index += 1
		
		if _previous_index > 0:
			_previous_index = 0
		
		_insert_previous_input()


func _insert_previous_input() -> void:
	if _previous_index == 0:
		console_input.text = ""
	else:
		console_input.text = _previous_input[_previous_index]


func _toggle_dev_console() -> void:
	visible = !visible
		
	if visible:
		console_input.text = ""
		console_input.grab_focus()
	else:
		console_input.release_focus()
	
	EventsBus.dev_console_toggled.emit(visible)
	get_viewport().set_input_as_handled()


func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text == "": return
	
	_previous_input.append(new_text)
	
	if _previous_input.size() > 50:
		_previous_input.pop_front()
	
	_previous_index = 0
	var parts = new_text.split(" ")
	
	match parts[0]:
		"mute":
			var enabled := AudioServer.is_bus_mute(AudioServer.get_bus_index("Master"))
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), !enabled)
			EventsBus.notification_submitted.emit("Master bus mute set to " + str(!enabled))
		"activate":
			if parts.size() == 1:
				EventsBus.notification_submitted.emit("Must specify a lift to activate")
			else:
				EventsBus.activate_lift.emit(parts[1])
				EventsBus.notification_submitted.emit("Activate lift " + parts[1])
		"commentary":
			Globals.commentary_enabled = !Globals.commentary_enabled
			EventsBus.toggle_commentary.emit()
		_:
			EventsBus.notification_submitted.emit("Unrecognised command '" + new_text + "'")
	
	console_input.text = ""


func _regain_focus_after_pause(pause_state: bool) -> void:
	if not pause_state and visible:
		call_deferred("_focus_console_input")


func _focus_console_input() -> void:
	console_input.release_focus()
	console_input.grab_focus()
