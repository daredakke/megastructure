class_name DevConsoleOutputLine
extends PanelContainer


var text_content: String = ""

@onready var output_text: RichTextLabel = $MarginContainer/HBoxContainer/OutputText
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	output_text.text = text_content
	animation_player.play("dev_console_output_fade_out")
	audio_stream_player.pitch_scale = randf_range(0.9, 1.1)
	audio_stream_player.play()


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
