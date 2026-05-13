class_name Lift
extends Node3D


@export var travel_speed: float = 5.0
@export var start_at_bottom: bool = true

var active: bool = false
var is_going_up: bool = false

@onready var body: MaterialBody = $Body
@onready var bottom: Marker3D = $Bottom
@onready var top: Marker3D = $Top
@onready var drone: AudioStreamPlayer = $Drone
@onready var beep: AudioStreamPlayer = $Beep


func _ready() -> void:
	EventsBus.activate_lift.connect(activate)
	body.position = bottom.position if start_at_bottom else top.position


func _physics_process(delta: float) -> void:
	if not active:
		drone.stop()
		return
	
	if !drone.playing:
		drone.play()
	
	if is_going_up:
		body.position.y += travel_speed * delta
		
		if body.position.y >= top.position.y:
			body.position = top.position
			active = false
	else:
		body.position.y -= travel_speed * delta
		
		if body.position.y <= bottom.position.y:
			body.position = bottom.position
			active = false


func activate(lift_name: String) -> void:
	if name != lift_name: return
	if active: return
	
	is_going_up = true if body.position.y == bottom.position.y else false
	active = true
	beep.play()
