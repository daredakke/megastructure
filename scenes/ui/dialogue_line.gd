class_name DialogueLine
extends Control


const SFX_BUTTON = preload("uid://cqw38xd3xq3va")

@onready var speaker_label: RichTextLabel = $SpeakerMargin/SpeakerLabel
@onready var line_label: RichTextLabel = $MarginContainer/Dialogue/MarginContainer/VBoxContainer/LineLabel
@onready var next_line_indicator: MarginContainer = $MarginContainer/NextLineIndicator
@onready var choices_container: MarginContainer = $MarginContainer/Choices
@onready var choices_v_box: VBoxContainer = $MarginContainer/Choices/ChoicesVBox


func _ready() -> void:
	EventsBus.dev_console_toggled.connect(choice_grab_focus)
	EventsBus.game_paused.connect(choice_grab_focus)


func _unhandled_input(_event: InputEvent) -> void:
	# Do not advance via interact key if a choice is to be made
	if choices_v_box.get_children().size() == 0 and Input.is_action_just_pressed("interact"):
		EventsBus.dialogue_advanced.emit()


## Repeated timer timeouts make the next line indicator blink.
func _on_next_line_indicator_timer_timeout() -> void:
	next_line_indicator.visible = !next_line_indicator.visible


func update_speaker_label(speaker: String) -> void:
	speaker_label.text = speaker


func update_line_label(line: String) -> void:
	line_label.text = line


## Handle the display of choices.
func create_choices(choices: Array) -> void:
	for choice in choices:
		var button = SFX_BUTTON.instantiate() as SfxButton
		choices_v_box.add_child(button)
		button.text = choice.text
		button.branch_name = choice.branch
	
	var idx: int = 0
	var array_size: int = choices_v_box.get_children().size()
	var next: NodePath
	var previous: NodePath
	
	for button in choices_v_box.get_children():
		previous = choices_v_box.get_children()[array_size - 1 if idx - 1 < 0 else idx - 1].get_path()
		next = choices_v_box.get_children()[0 if idx + 1 == array_size else idx + 1].get_path()
		
		button.set_focus_neighbor(SIDE_TOP, previous)
		button.set_focus_neighbor(SIDE_BOTTOM, next)
		
		idx += 1
	
	choice_grab_focus(false)


## Ensure choices have focus unless the dev console or pause menu are visible.
func choice_grab_focus(other_ui_visible: bool) -> void:
	if other_ui_visible: return
	if choices_v_box.get_children().size() == 0: return
	
	choices_v_box.get_children()[0].grab_focus()


func hide_choices() -> void:
	choices_container.hide()
