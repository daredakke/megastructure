class_name Torch
extends SpotLight3D


const DIM_CHANCE: float = 0.03

var _energy_reduction: float = 0.0
var _add_dim_chance: float = 0.0
var _range_reduction: float = 0.0

var is_silent: bool = true

@onready var _energy: float = light_energy
@onready var _base_range: float = spot_range
@onready var torch_click_sfx: AudioStreamPlayer = $TorchClickSFX


func _ready() -> void:
	EventsBus.player_landed_hard.connect(impact_dimming)


func _process(delta: float) -> void:
	_energy_reduction = clampf(_energy_reduction - delta, 0.0, 1.3)
	_add_dim_chance = clampf(_add_dim_chance - delta, 0.0, 0.6)
	_range_reduction = clampf(_range_reduction - delta, 0.0, 13.0)


func _on_torch_flicker_timer_timeout() -> void:
	var decrease: float = 0.5 + _energy_reduction

	if randf() < DIM_CHANCE + _add_dim_chance:
		decrease += randf() + 0.8

	light_energy = randf_range(_energy - decrease, _energy)
	spot_range = _base_range - _range_reduction


func impact_dimming(strength: float) -> void:
	_energy_reduction = 0.3 + strength
	_add_dim_chance = strength / 2
	_range_reduction = strength * 10


func _on_visibility_changed() -> void:
	if is_silent: return
	
	torch_click_sfx.play()
	torch_click_sfx.pitch_scale = randf_range(1.08, 1.12)
