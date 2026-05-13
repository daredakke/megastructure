class_name DevConsole
extends Control


@onready var console_input: LineEdit = $ConsoleInput


func _ready() -> void:
	EventsBus.game_paused.connect(_regain_focus_after_pause)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("dev"):
		_toggle_dev_console()


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
	var parts = new_text.split(" ")
	
	match parts[0]:
		"mute":
			var enabled := AudioServer.is_bus_mute(AudioServer.get_bus_index("Master"))
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), !enabled)
			print("DEV: Master bus mute set to ", !enabled)
		"activate":
			if parts.size() == 1:
				print("DEV: Must specify a lift to activate")
			else:
				EventsBus.activate_lift.emit(parts[1])
				print("DEV: Activate lift ", parts[1])
		"commentary":
			Globals.commentary_enabled = !Globals.commentary_enabled
			EventsBus.toggle_commentary.emit()
		_:
			print("DEV: Unrecognised command")
	
	_toggle_dev_console()


func _regain_focus_after_pause(pause_state: bool) -> void:
	if not pause_state and visible:
		call_deferred("_focus_console_input")


func _focus_console_input() -> void:
	console_input.release_focus()
	console_input.grab_focus()
