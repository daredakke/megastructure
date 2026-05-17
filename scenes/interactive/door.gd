class_name Door
extends Node3D


@export var is_locked: bool = false
@export var move_speed: float = 5.5
## How far to move the door when it's open.
@export var offset: float = 1.9

var active: bool = false

var _is_open: bool = false

@onready var door_body: StaticBody3D = $Body
@onready var body_original_pos: Vector3 = $Body.position
@onready var detection_area: Area3D = $DetectionArea
@onready var door_sfx: AudioStreamPlayer = $Sfx


func _process(delta: float) -> void:
	if not active: return
	
	# Process door opening or closing
	if _is_open:
		door_body.position.x += move_speed * delta
		
		if door_body.position.x >= body_original_pos.x + offset:
			door_body.position.x = body_original_pos.x + offset
			active = false
	else:
		door_body.position.x -= move_speed * delta
		
		if door_body.position.x <= body_original_pos.x:
			door_body.position.x = body_original_pos.x
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
