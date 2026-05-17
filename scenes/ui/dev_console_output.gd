class_name DevConsoleOutput
extends MarginContainer


const DEV_CONSOLE_OUTPUT_LINE = preload("uid://5rfe276e3wr8")

@onready var output_v_box: VBoxContainer = $OutputVBox


func _ready() -> void:
	EventsBus.notification_submitted.connect(create_dev_console_output_line)


## Creates a new dev notification.
func create_dev_console_output_line(text: String) -> void:
	var output_line := DEV_CONSOLE_OUTPUT_LINE.instantiate() as DevConsoleOutputLine
	
	output_line.text_content = text
	output_v_box.add_child(output_line)
	output_line.move_to_front()
	output_line.shake_notification(50.0, 2.0)
