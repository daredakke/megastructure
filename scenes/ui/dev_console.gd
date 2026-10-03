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
	
	# Up arrow key scrolls backward through previous input
	if Input.is_action_just_pressed("ui_up") and visible:
		_previous_index -= 1
		
		if abs(_previous_index) > _previous_input.size():
			_previous_index = -_previous_input.size()
		
		_insert_previous_input()
	
	# Down arrow key scrolls forward through previous input 
	if Input.is_action_just_pressed("ui_down") and visible:
		_previous_index += 1
		
		if _previous_index > 0:
			_previous_index = 0
		
		_insert_previous_input()


## Place previous input in dev console or nothing if back at the start.
func _insert_previous_input() -> void:
	if _previous_index == 0:
		console_input.text = ""
	else:
		console_input.text = _previous_input[_previous_index]


## Show or hide the dev console (if game is unpaused).
func _toggle_dev_console() -> void:
	visible = !visible
		
	if visible:
		console_input.text = ""
		console_input.grab_focus()
	else: 
		console_input.release_focus()
	
	EventsBus.dev_console_toggled.emit(visible)
	
	# Stop input from propogating up the scene tree
	get_viewport().set_input_as_handled()


## Handle dev console input.
func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text == "":
		return
	
	# Store up to 50 previous inputs
	_previous_input.append(new_text)
	
	if _previous_input.size() > 50:
		_previous_input.pop_front()
	
	_previous_index = 0
	
	# Split input on spaces, useful if commands can be given arguments
	var parts = new_text.split(" ")
	
	# Determine which command was given
	match parts[0]:
		# Mutes the game audio entirely
		"mute":
			var enabled := AudioServer.is_bus_mute(AudioServer.get_bus_index("Master"))
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), !enabled)
			EventsBus.notification_submitted.emit("Master bus mute set to " + str(!enabled))
			
		# Activate a lift in the scene with a given name
		# Format: activate <lift_name>
		"activate":
			if parts.size() == 1:
				EventsBus.notification_submitted.emit("Must specify a lift to activate")
			else:
				EventsBus.activate_lift.emit(parts[1])
				EventsBus.notification_submitted.emit("Activate lift " + parts[1])
		
		# Reveal dev commentary nodes throughout the game
		"commentary":
			Globals.commentary_enabled = !Globals.commentary_enabled
			
			var state: String = "revealed" if Globals.commentary_enabled else "hidden"
			
			EventsBus.toggle_commentary.emit()
			EventsBus.notification_submitted.emit("Commentary nodes '" + state + "'")
		
		"help":
			EventsBus.notification_submitted.emit("Available commands: commentary, help, mute")
		
		# All other input
		_:
			EventsBus.notification_submitted.emit("Unrecognised command '" + new_text + "'")
	
	console_input.text = ""


## Ensure the dev console gets focus again after unpausing the game.
func _regain_focus_after_pause(pause_state: bool) -> void:
	if not pause_state and visible:
		console_input.call_deferred("grab_focus")
