class_name DeathScreen
extends Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	EventsBus.player_died.connect(show)
	EventsBus.player_died.connect(animation_player.play.bind("red_panel_fade_out"))
	EventsBus.player_respawned.connect(hide)

	hide()
