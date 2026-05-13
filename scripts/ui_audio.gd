class_name UiAudio
extends Node


@onready var button_hover: AudioStreamPlayer = $ButtonHover
@onready var button_click: AudioStreamPlayer = $ButtonClick


func _ready() -> void:
	EventsBus.button_hovered.connect(button_hover.play)
	EventsBus.button_pressed.connect(button_click.play)
