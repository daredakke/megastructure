class_name Main
extends Node


# The file user settings are saved in
const USER_SETTINGS: String = "user://megastructure-settings.dat"

var game_paused: bool = false

var _loaded_settings = null

@onready var screen_size: Vector2i = DisplayServer.screen_get_size(DisplayServer.window_get_current_screen())
@onready var level_controller: LevelController = %LevelController
@onready var ui: Control = $UI
@onready var dialogue_controller: DialogueController = %DialogueController
@onready var pause_menu: PauseMenu = %PauseMenu


func _enter_tree() -> void:
	# Check for saved user settings and load them if it exists
	if FileAccess.file_exists(USER_SETTINGS):
		var file = FileAccess.open(USER_SETTINGS, FileAccess.READ)
		_loaded_settings = file.get_var()
		file = null


func _ready() -> void:
	pause_menu.visible = game_paused
	
	get_viewport().audio_listener_enable_3d = true
	
	# Ensure all UI elements are hidden by default
	for child in ui.get_children():
		child.hide()
	
	EventsBus.settings_for_saving.connect(save_settings)
	EventsBus.resolution_changed.connect(change_resolution)
	EventsBus.aa_changed.connect(change_anti_aliasing)
	EventsBus.af_changed.connect(change_anisotropic_filtering)
	EventsBus.vsync_toggled.connect(change_vsync_state)
	EventsBus.volume_changed.connect(change_volume)
	
	if not _loaded_settings: return
	
	# Apply loaded user settings
	pause_menu.update_resolution_options(screen_size.y)
	pause_menu.update_display_mode(_loaded_settings.mode)
	pause_menu.update_resolution_value(_loaded_settings.resolution)
	pause_menu.update_aa_value(_loaded_settings.aa)
	pause_menu.update_af_value(_loaded_settings.af)
	pause_menu.update_vsync_toggled_status(_loaded_settings.vsync)
	pause_menu.update_fov_slider_label_text(_loaded_settings.fov)
	pause_menu.update_look_sens_label_text(_loaded_settings.look_sensitivity)
	pause_menu.update_controller_look_sens_label_text(_loaded_settings.con_look_sensitivity)
	pause_menu.update_music_slider_label_text(_loaded_settings.music_volume)
	pause_menu.update_sfx_slider_label_text(_loaded_settings.sfx_volume)
	
	change_resolution(_loaded_settings.mode, _loaded_settings.resolution)
	change_anti_aliasing(_loaded_settings.aa)
	change_anisotropic_filtering(_loaded_settings.af)

	Globals.fov = _loaded_settings.fov
	Globals.look_sensitivity = _loaded_settings.look_sensitivity
	Globals.controller_look_sensitivity = _loaded_settings.con_look_sensitivity


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		handle_pause()


func handle_pause():
	game_paused = !game_paused
	
	if game_paused:
		level_controller.process_mode = Node.PROCESS_MODE_DISABLED
		ui.process_mode = Node.PROCESS_MODE_DISABLED
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		level_controller.process_mode = Node.PROCESS_MODE_ALWAYS
		ui.process_mode = Node.PROCESS_MODE_ALWAYS
		
		# Don't capture mouse if unpausing to return to dialogue
		if dialogue_controller.get_children().size() == 0:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	pause_menu.visible = game_paused
	pause_menu.hide_settings_panel()
	EventsBus.game_paused.emit(game_paused)


func change_resolution(mode: int, resolution_idx: int) -> void:
	# Windowed
	if mode == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		ProjectSettings.set_setting("display/window/size/borderless", false)
		get_window().size = SettingsConfig.get_resolution_vector(resolution_idx)
		get_window().move_to_center()
		get_viewport().scaling_3d_scale = 1.0
		return
	
	# Fullscreen
	if mode == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	ProjectSettings.set_setting("display/window/size/borderless", true)
	
	# Determine fullscreen render scale
	var h = screen_size.y
	var res_h: int = SettingsConfig.get_resolution_vector(resolution_idx).y
	get_viewport().scaling_3d_scale = clampf(float(res_h) / h, 0.0, 1.0)


func change_anti_aliasing(mode: int) -> void:
	var viewport_rid := get_viewport().get_viewport_rid()
	# Disable all anti-aliasing
	RenderingServer.viewport_set_screen_space_aa(viewport_rid, RenderingServer.VIEWPORT_SCREEN_SPACE_AA_DISABLED)
	RenderingServer.viewport_set_msaa_3d(viewport_rid, RenderingServer.VIEWPORT_MSAA_DISABLED)
	
	# Which mode to enable
	match mode:
		1: # FXAA
			RenderingServer.viewport_set_screen_space_aa(viewport_rid, RenderingServer.VIEWPORT_SCREEN_SPACE_AA_FXAA)
		2: # MSAA 2x
			RenderingServer.viewport_set_msaa_3d(viewport_rid, RenderingServer.VIEWPORT_MSAA_2X)
		3: # MSAA 4x
			RenderingServer.viewport_set_msaa_3d(viewport_rid, RenderingServer.VIEWPORT_MSAA_4X)
		4: # MSAA 8x
			RenderingServer.viewport_set_msaa_3d(viewport_rid, RenderingServer.VIEWPORT_MSAA_8X)


func change_anisotropic_filtering(mode: int) -> void:
	var viewport_rid := get_viewport().get_viewport_rid()
	
	match mode:
		0:
			RenderingServer.viewport_set_anisotropic_filtering_level(viewport_rid, RenderingServer.VIEWPORT_ANISOTROPY_DISABLED)
		1:
			RenderingServer.viewport_set_anisotropic_filtering_level(viewport_rid, RenderingServer.VIEWPORT_ANISOTROPY_2X)
		2:
			RenderingServer.viewport_set_anisotropic_filtering_level(viewport_rid, RenderingServer.VIEWPORT_ANISOTROPY_4X)
		3:
			RenderingServer.viewport_set_anisotropic_filtering_level(viewport_rid, RenderingServer.VIEWPORT_ANISOTROPY_8X)
		4:
			RenderingServer.viewport_set_anisotropic_filtering_level(viewport_rid, RenderingServer.VIEWPORT_ANISOTROPY_16X)


func change_vsync_state(enabled: bool) -> void:
	if enabled:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func change_volume(bus_index: int, value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	AudioServer.set_bus_mute(bus_index, value < 0.05)


func save_settings(settings: Dictionary) -> void:
	var file = FileAccess.open(USER_SETTINGS, FileAccess.WRITE_READ)
	file.store_var(settings)
	file = null
