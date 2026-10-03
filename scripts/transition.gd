extends Node


## This is just here so there's a loading screen before the gallery
func _on_transition_timer_timeout() -> void:
	EventsBus.scene_changed.emit(LevelConfig.Keys.HoleInGround, "Start", false)
