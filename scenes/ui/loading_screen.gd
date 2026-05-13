class_name LoadingScreen
extends Control


func _ready() -> void:
	EventsBus.loading_screen_shown.connect(show)
	EventsBus.loading_screen_hidden.connect(hide)
