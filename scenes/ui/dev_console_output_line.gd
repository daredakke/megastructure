class_name DevConsoleOutputLine
extends MarginContainer


const SHAKE_DECAY_RATE: float = 10

var _shake_speed: float:
	set(value):
		_shake_speed = clampf(value, 0.0, 100.0)
var _noise_i: float = 0.0
var _shake_strength: float = 0.0:
	set(value):
		_shake_strength = clampf(value, 0.0, 100.0)

var text_content: String = ""

@onready var output_text: RichTextLabel = $PanelContainer/MarginContainer/HBoxContainer/OutputText
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var noise = FastNoiseLite.new()


func _ready() -> void:
	output_text.text = text_content
	animation_player.play("dev_console_output_fade_out")
	# Modulate pop pitch
	audio_stream_player.pitch_scale = randf_range(0.9, 1.1)
	audio_stream_player.play()


## Handle left/right shake.
func _process(delta: float) -> void:
	if _shake_strength == 0.0:
		return
	
	var offset: float = _shake_decay(delta, SHAKE_DECAY_RATE)
	
	# Make the shake more violent
	if randf() > 0.5:
		offset = -offset
	
	self.add_theme_constant_override("margin_left", int(offset))


## Remove notification from tree once fade out has concluded.
func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()


## Calculate how much shake for the given parameters.
func _shake_decay(delta: float, decay_rate: float) -> float:
	_shake_strength = lerp(_shake_strength, 0.0, decay_rate * delta)
	_noise_i += delta * _shake_speed

	return noise.get_noise_2d(randf_range(50.0, 75.0), _noise_i) * _shake_strength


## Initiate shaking.
func shake_notification(strength: float, speed: float) -> void:
	_shake_strength = strength
	_shake_speed = speed
