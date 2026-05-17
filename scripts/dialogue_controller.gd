class_name DialogueController
extends Control
## Handles dialogue interactions, including starting, stopping, moving 
## between lines and branching paths.


const DIALOGUE_LINE = preload("uid://beeudk174oodi")
const DEFAULT_BRANCH: String = "start"

var current_dialogue_lines: Dictionary
var current_branch_index: String
var current_index: int = -1
var previous_dialogue_line: Dictionary


func _ready() -> void:
	EventsBus.player_interacted.connect(_begin_new_dialogue)
	EventsBus.dialogue_advanced.connect(_show_next_dialogue_line)
	EventsBus.choice_made.connect(_change_dialogue_branch)


## Start a new dialogue interaction.
func _begin_new_dialogue(dialogue_index: Dialogue.Keys) -> void:
	show()
	
	current_dialogue_lines = Dialogue.get_dialogue_lines(dialogue_index)
	current_branch_index = DEFAULT_BRANCH
	current_index = -1
	
	_show_next_dialogue_line()


## Move to the next line of dialogue.
func _show_next_dialogue_line() -> void:
	if get_children().size() > 0:
		get_children()[0].queue_free()
	
	current_index += 1
	
	# This branch has ended without transferring to a new one, end the dialogue
	if current_index >= current_dialogue_lines[current_branch_index].size():
		hide()
		EventsBus.dialogue_ended.emit()
		return
	
	var dialogue_screen = DIALOGUE_LINE.instantiate() as DialogueLine
	
	add_child(dialogue_screen)
	
	var current_dialogue_dict = current_dialogue_lines[current_branch_index][current_index]
	
	dialogue_screen.update_line_label(current_dialogue_dict.line)
	
	if current_dialogue_dict.has("speaker"):
		dialogue_screen.update_speaker_label(current_dialogue_dict.speaker)
	
	if current_dialogue_dict.has("choices"):
		dialogue_screen.create_choices(current_dialogue_dict.choices)
	else:
		dialogue_screen.hide_choices()
	
	if current_dialogue_dict.has("branch"):
		current_branch_index = current_dialogue_dict.branch
		current_index = -1


## Move to a different branching path.
func _change_dialogue_branch(new_branch: String) -> void:
	current_branch_index = new_branch
	current_index = -1
	_show_next_dialogue_line()
