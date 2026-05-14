extends Node


signal game_paused(state: bool)
signal scene_changed(level: LevelConfig.Keys, spawn_location: String, torch_is_on: bool)
signal loading_screen_shown
signal loading_screen_hidden
signal player_died
signal player_respawned
signal player_landed_hard(strength: float)
signal player_space_openness(openness: float)
signal player_interacted(dialogue_index: Dialogue.Keys)
signal dialogue_advanced
signal dialogue_ended
signal choice_made(choice: String)
signal dev_console_toggled(is_visible: bool)
signal notification_submitted(text: String)
signal button_hovered
signal button_pressed
signal tab_button_pressed(tab_name: String)
signal resolution_changed(mode: int, resolution: String)
signal aa_changed(mode: int)
signal af_changed(mode: int)
signal vsync_toggled(toggled_on: bool)
signal fov_changed(value: float)
signal look_sens_changed(value: float)
signal controller_look_sens_changed(value: float)
signal volume_changed(bus: int, value: float)
signal settings_for_saving(settings: Dictionary)
signal activate_lift(lift_name: String)
