class_name Door
extends Node3D


@export var is_locked: bool = false
@export var move_speed: float = 5.5
## How far to move the door when it's open.
@export var offset: float = 1.9

var active: bool = false

var _door_body: MaterialBody
var _body_original_pos: Vector3
var _is_open: bool = false

@onready var detection_area: Area3D = $DetectionArea
@onready var door_sfx: AudioStreamPlayer = $Sfx


func _ready() -> void:
	for node in get_children():
		if node is MaterialBody:
			print("Found material body")
			_door_body = node
			_body_original_pos = node.position
		
		break


func _process(delta: float) -> void:
	if not active or not _door_body: return
	
	# Process door opening or closing
	if _is_open:
		_door_body.position.x += move_speed * delta
		
		if _door_body.position.x >= _body_original_pos.x + offset:
			_door_body.position.x = _body_original_pos.x + offset
			active = false
	else:
		_door_body.position.x -= move_speed * delta
		
		if _door_body.position.x <= _body_original_pos.x:
			_door_body.position.x = _body_original_pos.x
			active = false


func _on_detection_area_body_entered(body: Node3D) -> void:
	if is_locked: return
	
	# Only open for the player if door is unlocked
	if body is FpsController:
		active = true
		_is_open = true
		door_sfx.play()


func _on_detection_area_body_exited(body: Node3D) -> void:
	if is_locked: return
	
	if body is FpsController:
		active = true
		_is_open = false
		door_sfx.play()
