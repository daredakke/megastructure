class_name PauseMenu
extends Control


signal resume_button_pressed

var _music_bus: int = AudioServer.get_bus_index("Music")
var _sfx_bus: int = AudioServer.get_bus_index("SFX")

@onready var resume_button: SfxButton = $MainMenuPanel/MarginContainer/VBoxContainer/ResumeButton
@onready var settings_button: SfxButton = $MainMenuPanel/MarginContainer/VBoxContainer/SettingsButton
@onready var settings_panel: Panel = $SettingsPanel
@onready var back_button: SfxButton = %BackButton
@onready var windowed_check_box: CheckBox = %WindowedCheckBox
@onready var borderless_check_box: CheckBox = %BorderlessCheckBox
@onready var fullscreen_check_box: CheckBox = %FullscreenCheckBox
@onready var resolution_option: OptionButton = %ResolutionOption
@onready var anti_aliasing_option: OptionButton = %AntiAliasingOption
@onready var anisotropic_filter_option: OptionButton = %AnisotropicFilterOption
@onready var v_sync_check_button: CheckButton = %VSyncCheckButton
@onready var fov_label: Label = %FOVLabel
@onready var fov_slider: HSlider = %FOVSlider
@onready var sensitivity_label: Label = %SensitivityLabel
@onready var sensitivity_slider: HSlider = %SensitivitySlider
@onready var con_sensitivity_label: Label = %ConSensitivityLabel
@onready var con_sensitivity_slider: HSlider = %ConSensitivitySlider
@onready var music_label: Label = %MusicLabel
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_label: Label = %SFXLabel
@onready var sfx_slider: HSlider = %SFXSlider
@onready var tabs: HBoxContainer = %Tabs
@onready var tab_contents: MarginContainer = %TabContents


func _ready() -> void:
	EventsBus.tab_button_pressed.connect(_on_tab_button_pressed)
	
	# Add resolutions to dropdown
	resolution_option.clear()
	
	for res in SettingsConfig.resolutions:
		resolution_option.add_item(res["string"])
	
	# Ensure all menus are hidden on start
	settings_panel.hide()
	hide()


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		hide_settings_panel()


func _on_resume_button_pressed() -> void:
	resume_button_pressed.emit()


func _on_settings_button_pressed() -> void:
	settings_panel.show()
	back_button.grab_focus()


func _quit_game() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_back_button_pressed() -> void:
	hide_settings_panel()


func _get_screen_mode() -> int:
	if borderless_check_box.button_pressed:
		return 1
	elif fullscreen_check_box.button_pressed:
		return 2
	
	return 0


func _on_tab_button_pressed(tab_name: String) -> void:
	for btn in tabs.get_children():
		if btn.name == tab_name:
			btn.is_active = true
			
			var prefix: String = tab_name.split("Tab")[0]
			
			for vbox in tab_contents.get_children():
				if vbox.name == prefix + "VBox":
					vbox.show()
				else:
					vbox.hide()
		else:
			btn.is_active = false
			btn.button_pressed = false


func _on_mode_check_box_toggled(_toggled_on: bool) -> void:
	EventsBus.resolution_changed.emit(_get_screen_mode(), resolution_option.selected)
	send_game_settings()


func _on_resolution_option_selected(index: int) -> void:
	EventsBus.resolution_changed.emit(_get_screen_mode(), index)
	send_game_settings()


func _on_anti_aliasing_option_item_selected(index: int) -> void:
	EventsBus.aa_changed.emit(index)
	send_game_settings()


func _on_anisotropic_filter_option_item_selected(index: int) -> void:
	EventsBus.af_changed.emit(index)
	send_game_settings()


func _on_v_sync_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		v_sync_check_button.text = "ON "
	else:
		v_sync_check_button.text = "OFF"
	
	EventsBus.vsync_toggled.emit(toggled_on)
	send_game_settings()


func hide_settings_panel() -> void:
	settings_panel.hide()
	resume_button.grab_focus()


func send_game_settings() -> void:
	EventsBus.settings_for_saving.emit({
		"mode": _get_screen_mode(),
		"resolution": resolution_option.selected,
		"aa": anti_aliasing_option.selected,
		"af": anisotropic_filter_option.selected,
		"vsync": v_sync_check_button.button_pressed,
		"fov": fov_slider.value,
		"music_volume": music_slider.value,
		"sfx_volume": sfx_slider.value,
		"look_sensitivity": sensitivity_slider.value,
		"con_look_sensitivity": con_sensitivity_slider.value
	})


func update_display_mode(mode: int) -> void:
	if mode == 1:
		borderless_check_box.button_pressed = true
	elif mode == 2:
		fullscreen_check_box.button_pressed = true
	else:
		windowed_check_box.button_pressed = true


func update_resolution_options(screen_height: int) -> void:
	var idx = 0
	
	while idx < resolution_option.item_count:
		if int(resolution_option.get_item_text(idx).split("x")[1]) > screen_height:
			resolution_option.remove_item(idx)
			idx -= 1
		
		idx += 1


func update_resolution_value(idx: int) -> void:
	resolution_option.select(idx)


func update_aa_value(mode: int) -> void:
	anti_aliasing_option.select(mode)


func update_af_value(mode: int) -> void:
	anisotropic_filter_option.select(mode)


func update_vsync_toggled_status(toggled_on: bool) -> void:
	v_sync_check_button.button_pressed = toggled_on


func update_fov_slider_label_text(value: float) -> void:
	fov_label.text = "FIELD OF VIEW (" + str(int(value)) + ")"
	fov_slider.value = value
	Globals.fov = fov_slider.value
	EventsBus.fov_changed.emit(fov_slider.value)
	send_game_settings()


func update_look_sens_label_text(value: float) -> void:
	sensitivity_label.text = "MOUSE SENSITIVITY (" + str(value) + ")"
	sensitivity_slider.value = value
	Globals.look_sensitivity = sensitivity_slider.value
	EventsBus.look_sens_changed.emit(sensitivity_slider.value)
	send_game_settings()


func update_controller_look_sens_label_text(value: float) -> void:
	con_sensitivity_label.text = "CONTROLLER SENSITIVITY (" + str(value) + ")"
	con_sensitivity_slider.value = value
	Globals.controller_look_sensitivity = con_sensitivity_slider.value
	EventsBus.controller_look_sens_changed.emit(con_sensitivity_slider.value)
	send_game_settings()


func update_music_slider_label_text(value: float) -> void:
	music_label.text = "MUSIC VOLUME (" + str(floor(value * 100)) + "%)"
	music_slider.value = value
	EventsBus.volume_changed.emit(_music_bus, value)
	send_game_settings()


func update_sfx_slider_label_text(value: float) -> void:
	sfx_label.text = "SFX VOLUME (" + str(floor(value * 100)) + "%)"
	sfx_slider.value = value
	EventsBus.volume_changed.emit(_sfx_bus, value)
	send_game_settings()
