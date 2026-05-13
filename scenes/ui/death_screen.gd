class_name DeathScreen
extends Control


func _ready() -> void:
	EventsBus.player_died.connect(show)
	EventsBus.player_respawned.connect(hide)

	hide()
