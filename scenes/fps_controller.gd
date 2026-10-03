class_name FpsController
extends CharacterBody3D


const HOLD_TIME_FOR_RESPAWN: int = 25
const TERMINAL_VELOCITY: float = -37.5
const MAX_STEP_HEIGHT: float = 5.0
const CROUCH_TRANSLATE: float = 0.5
const CROUCH_JUMP_ADD: float = CROUCH_TRANSLATE * 0.9
const MAX_HEAD_TILT: float = 1.5
const HEAD_TILT_SPEED: int = 15
const MAX_COYOTE_TIME: int = 10
const FOV_TRANSITION_SPEED: float = 2.0
const NOCLIP_SPEED_MULTIPLIER_DEFAULT: float = 3.0
const TIME_TO_NEXT_FOOTSTEP: float = 2.2
const TIME_TO_NEXT_LADDER_SFX: int = 60
const SHAKE_DECAY_RATE: float = 10
const WIND_RUSH_MIN_VELOCITY: float = 13.5
const MAX_REVERB_DISTANCE: float = 50
const INTERACT_DISTANCE: float = 2.0
const ZOOM_FOV_REDUCTION: float = 40.0
const ZOOM_LOOK_STRENGTH_REDUCTION: float = 0.5

var _player_is_dead: bool = false
var _player_is_frozen: bool = false
var _player_can_interact: bool = true
var _respawn_hold_counter: int = 0
var _just_spawned: bool = true
var _just_respawned: bool = false
var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var _gravity_vector = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
var _reverb_bus := AudioServer.get_bus_index("Reverb")
var _norm_room_size: float
var _norm_openness: float
var _norm_reflectiveness: float
var _target_room_size: float
var _target_damping: float
var _target_predelay_msec: float
var _target_predelay_feedback: float
var _target_reverb_wet: float
var _cur_controller_look := Vector2()
var _current_air_friction: float
var _player_jumped_into_air: bool = false
var _was_sprinting_when_jumped: bool = false
var _last_ground_y: float # Stores player's last grounded y position
var _footstep_counter: float = 0.0
var _is_ledge_grabbing: bool = false
var _coyote_counter: int = 0
var _shake_speed: float:
	set(value):
		_shake_speed = clampf(value, 0.0, 100.0)
var _noise_i: float = 0.0
var _shake_strength: float = 0.0:
	set(value):
		_shake_strength = clampf(value, 0.0, 100.0)

var base_move_speed: float = 5
var cam_aligned_wish_dir := Vector3.ZERO
var base_camera_fov: float = 70.0
var sprint_fov_amount: float = 7.5
var jump_velocity: float = 5.25
var ground_friction: float = 5.0
var air_friction: float = 1.5
var safe_fall_distance: float = 12.0
var is_sprinting: bool = false
var is_crouched: bool = false
var look_sensitivity: float = 0.006
var controller_look_sensitivity: float = 0.03
var player_is_frozen: bool = false
var noclipping: bool = false
var noclip_speed_multiplier := NOCLIP_SPEED_MULTIPLIER_DEFAULT
var respawn_position := Vector3.ZERO
var respawn_orientation := Vector3.ZERO
var room_size_ray_count: int = 64

@onready var world_model: Node3D = $WorldModel
@onready var mesh_instance: MeshInstance3D = $WorldModel/MeshInstance3D
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var _original_capsule_height = $CollisionShape3D.shape.height
@onready var head: Node3D = $HeadOriginalPosition/Head
@onready var camera: Camera3D = $HeadOriginalPosition/Head/Camera3D
@onready var torch: SpotLight3D = $HeadOriginalPosition/Head/Camera3D/SpringArm3D/Torch
@onready var floor_below_ray: RayCast3D = $FloorBelowRayCast
@onready var floor_below_shape: ShapeCast3D = $FloorBelowShapeCast
@onready var space_ahead_ray_cast: RayCast3D = $SpaceAheadRayCast
@onready var ledge_ahead_ray_cast: RayCast3D = $LedgeAheadRayCast
@onready var room_size_rays: Node3D = $RoomSizeRayCasts
@onready var down: RayCast3D = $RoomSizeRayCasts/Down
@onready var noise = FastNoiseLite.new()
@onready var crosshair: Control = $Crosshair
@onready var wind_rushing_sfx: AudioStreamPlayer = $WindRushingSFX
@onready var death_sfx: AudioStreamPlayer = $DeathSFX
@onready var footstep_controller: FootstepController = $FootstepController
@onready var room_size_rays_timer: Timer = $RoomSizeRayCastTimer
@onready var interact_delay_timer: Timer = $InteractDelayTimer


func _ready() -> void:
	EventsBus.dev_console_toggled.connect(freeze_player)
	EventsBus.dialogue_ended.connect(unfreeze_player)
	
	mesh_instance.hide()
	
	update_camera_fov(Globals.fov)
	update_mouse_look_sensitivity(Globals.look_sensitivity)
	update_controller_look_sensitivity(Globals.controller_look_sensitivity)

	EventsBus.fov_changed.connect(update_camera_fov)
	EventsBus.look_sens_changed.connect(update_mouse_look_sensitivity)
	EventsBus.controller_look_sens_changed.connect(update_controller_look_sensitivity)
	
	_show_crosshair_icon("Base")
	update_wind_rushing_volume(0.0)
	wind_rushing_sfx.play()
	
	room_size_rays_timer.timeout.connect(_set_reverb_parameters)

	# Ensure existing raycasts are correct length
	for ray in room_size_rays.get_children():
		ray.target_position = ray.target_position.normalized() * MAX_REVERB_DISTANCE

	_generate_raycasts(room_size_ray_count, MAX_REVERB_DISTANCE)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	camera.fov = base_camera_fov
	_last_ground_y = global_position.y
	floor_max_angle = 1.1
	noise.seed = randi()
	noise.frequency = 0.5


func _process(delta: float) -> void:
	if _player_is_frozen or _player_is_dead or Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return
	
	_handle_controller_look_input(delta)
	_update_reverb_system(delta)
	
	# Screen shake
	var camera_offset: Vector2 = screen_shake_decay(delta, SHAKE_DECAY_RATE)
	camera.h_offset = camera_offset.x
	camera.v_offset = camera_offset.y


func _physics_process(delta: float) -> void:
	_handle_respawn()
	
	if _player_is_dead:
		return
	
	var npc := _check_for_npc()
	var switch := _check_for_switch()
	
	# Interactions
	if _player_can_interact:
		if npc:
			_show_crosshair_icon("SpeechIcon")
			
			if _player_can_interact and Input.is_action_just_pressed("interact"):
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				_show_crosshair_icon("")
				_player_is_frozen = true
				_player_can_interact = false
				EventsBus.player_interacted.emit(npc.dialogue_index)
		elif switch:
			_show_crosshair_icon("DoorIcon")
			
			if Input.is_action_just_pressed("interact"):
				switch.activate()
		else:
			_show_crosshair_icon("Base")
	
	if _player_is_frozen:
		return
	
	# Input
	var input_dir := Vector2.ZERO
	var head_rotation := 0.0
	var target_fov := base_camera_fov
	var fov_transition_multiplier := 3.0
	is_sprinting = false
	ledge_ahead_ray_cast.target_position = Vector3(0.0, 0.0, 0.0)
	var _grounded_status: int = 0
	
	input_dir = Input.get_vector("left", "right", "forward", "backward")
	
	# Determine if the player can sprint
	if velocity != Vector3.ZERO and input_dir.length() > 0.998 and Input.is_action_pressed("sprint") and Input.is_action_pressed("forward"):
		is_sprinting = true
		# Widen camera FOV if sprinting
		target_fov = base_camera_fov + sprint_fov_amount
		fov_transition_multiplier = 0.0
	
	if Input.is_action_pressed("zoom"):
		target_fov -= ZOOM_FOV_REDUCTION
	
	# Smoothly change camera FOV between running and sprinting states
	camera.fov = lerp(camera.fov, target_fov, (FOV_TRANSITION_SPEED + fov_transition_multiplier) * delta)
	
	# Tilt head left or right depending on sideways movement
	if input_dir.x != 0:
		head_rotation = MAX_HEAD_TILT * sqrt(pow(input_dir.x, 2.0)) * sign(input_dir.x) * -1
	
	head.rotation_degrees = head.rotation_degrees.lerp(Vector3(0, 0, head_rotation), HEAD_TILT_SPEED * delta)
	
	if Input.is_action_just_pressed("torch"):
		torch.visible = !torch.visible
	
	if _handle_noclip(delta, input_dir):
		return
	
	_handle_crouch(delta)
	
	var wish_dir := global_transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)
		
	if not is_on_floor():
		_handle_coyote_time()
		_handle_air_physics(delta, wish_dir)
		
		if not _is_ledge_grabbing: _handle_ledge_grab()
	else:
		# Player is dead if they hit the ground after falling too far
		if global_position.y - _last_ground_y < -safe_fall_distance:
			kill_player()
		
		_last_ground_y = global_position.y
		_player_jumped_into_air = false
		_was_sprinting_when_jumped = false
		_is_ledge_grabbing = false
		_coyote_counter = 0
		_grounded_status -= 1
		
		var collision = get_last_slide_collision()
		var floor_normal := Vector3.UP
		var steepness := 1.0
		
		if collision:
			floor_normal = collision.get_normal()
			steepness = clampf(acos(collision.get_angle()), 0.0, 1.0)
		else:
			# Determine steepness of floor below if just landed after being airborne
			down.force_raycast_update()
			
			if down.is_colliding():
				floor_normal = down.get_collision_normal()
				steepness = clampf(floor_normal.dot(Vector3.UP), 0.0, 1.0)
		
		# Slide player down steep slopes
		if steepness <= 0.77:
			var grav = _gravity_vector * _gravity
			var slide_speed = clampf(12.0 - steepness * 10.0, 0.0, 15.0)
			var slope_dir = grav - (grav.dot(floor_normal)) * floor_normal
			velocity += slope_dir * slide_speed * delta
		
		if Input.is_action_just_pressed("jump"):
			_handle_jump()

		_handle_ground_physics(delta, wish_dir)
	
	_player_falling_wind_rushing()
	move_and_slide()
	
	# A grounded status of 1 means the player landed on the ground this frame
	if is_on_floor() and not _just_respawned: _grounded_status += 1
	
	if _just_spawned:
		torch.is_silent = false
		_just_spawned = false
		return
	
	_handle_footsteps(delta, input_dir, _grounded_status)


func _unhandled_input(event: InputEvent) -> void:
	if _player_is_frozen or _player_is_dead or Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return
	
	# Handle mouse look
	if event is InputEventMouseMotion:
		var look_strength := look_sensitivity
		
		if Input.is_action_pressed("zoom"):
			look_strength *= ZOOM_LOOK_STRENGTH_REDUCTION
		
		rotate_y(-event.relative.x * look_strength)
		camera.rotate_x(-event.relative.y * look_strength)
		camera.rotation.x = clamp(camera.rotation.x, -PI * 0.5, PI * 0.5)
	
	# Scroll to change movement speed when noclipping
	if event is InputEventMouseButton and event.is_pressed() and noclipping:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			noclip_speed_multiplier = min(10.0, noclip_speed_multiplier * 1.1)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			noclip_speed_multiplier = max(1.0, noclip_speed_multiplier * 0.9)


func _handle_jump() -> void:
	var normal = get_floor_normal()
	var steepness: float = abs(normal.x) + abs(normal.z)
	
	floor_below_ray.force_raycast_update()
	
	# If the player is standing on flat ground while up against a steep slope, 
	# the player should jump as normal instead of bouncing away from the wall
	if floor_below_ray.is_colliding() and floor_below_ray.get_collision_normal().y == 1.0:
		steepness = 0.0
	
	# Player will jump away from steep slopes instead of up
	if steepness > 0.77:
		velocity = normal * jump_velocity * 0.8
	else:
		velocity.y = jump_velocity
	
	_current_air_friction = air_friction
	_player_jumped_into_air = true

	if is_sprinting:
		_was_sprinting_when_jumped = true


## Allows player to jump for a few frames after leaving the ground without jumping.
func _handle_coyote_time() -> void:
	if _player_jumped_into_air:
		return

	_coyote_counter += 1

	if _coyote_counter < MAX_COYOTE_TIME and Input.is_action_just_pressed("jump"):
		_handle_jump()


func _handle_crouch(delta: float) -> void:
	var was_crouched_last_frame = is_crouched
	
	if Input.is_action_pressed("crouch"):
		is_crouched = true
	# Can only uncrouch if there is room above to do so
	elif is_crouched and not test_move(global_transform, Vector3(0, CROUCH_TRANSLATE, 0)):
		is_crouched = false
	
	# Allow for crouch to heighten/extend a jump
	var translate_y_if_possible := 0.0
	
	# If there is a change in crouch state
	if was_crouched_last_frame != is_crouched and not is_on_floor():
		translate_y_if_possible = CROUCH_JUMP_ADD if is_crouched else -CROUCH_JUMP_ADD
	
	# Pull body up if possible instead of crouching in the air
	if translate_y_if_possible != 0.0:
		var result = KinematicCollision3D.new()
		test_move(global_transform, Vector3(0, translate_y_if_possible, 0), result)
		position.y += result.get_travel().y
		head.position.y -= result.get_travel().y
		head.position.y = clampf(head.position.y, -CROUCH_TRANSLATE, 0)
	
	head.position.y = move_toward(head.position.y, -CROUCH_TRANSLATE if is_crouched else 0.0, 7.0 * delta)
	collision_shape.shape.height = _original_capsule_height - CROUCH_TRANSLATE if is_crouched else _original_capsule_height
	collision_shape.position.y = collision_shape.shape.height * 0.5


func _handle_ledge_grab() -> void:
	# Can only ledge grab if player is moving down
	if velocity.y >= 0.0:
		return
	
	# Grow ledge ahead raycast when player is falling, prevents ledge grabbing too early
	var new_target_y: float = clampf(velocity.y * 0.5, -1.0, 0.0)
	ledge_ahead_ray_cast.target_position = Vector3(0.0, new_target_y, 0.0)
	
	ledge_ahead_ray_cast.force_raycast_update()
	space_ahead_ray_cast.force_raycast_update()
	floor_below_ray.force_raycast_update()
	
	# Prevent ledge grabbing of NPCs and switches
	if ledge_ahead_ray_cast.is_colliding() and ledge_ahead_ray_cast.get_collider() is Npc: return
	if ledge_ahead_ray_cast.is_colliding() and ledge_ahead_ray_cast.get_collider() is SwitchBody: return
	
	# Can only ledge grab if surface ahead is not too steep
	var ledge_normal = ledge_ahead_ray_cast.get_collision_normal()
	var steepness: float = abs(ledge_normal.x) + abs(ledge_normal.z)
	var can_ledge_jump: bool = ledge_ahead_ray_cast.is_colliding() and not space_ahead_ray_cast.is_colliding() and steepness < 0.45
	
	# Only let the player ledge grab if they under halfway to terminal velocity
	if can_ledge_jump and not floor_below_ray.is_colliding() and velocity.y >= TERMINAL_VELOCITY * 0.5:
		_show_crosshair_icon("LedgeGrabIcon")
		
		if Input.is_action_just_pressed("jump"):
			_coyote_counter = 0
			_handle_jump()
			_is_ledge_grabbing = true


func _handle_air_physics(delta: float, wish_dir: Vector3) -> void:
	# Decrease air friction after jumping for diminishing air control
	_current_air_friction = clampf(_current_air_friction - delta, 0.1, air_friction)
	
	velocity.x = lerp(velocity.x, wish_dir.x * get_move_speed(), _current_air_friction * delta)
	velocity.z = lerp(velocity.z, wish_dir.z * get_move_speed(), _current_air_friction * delta)
	velocity.y = clampf(velocity.y - _gravity * delta, TERMINAL_VELOCITY, abs(TERMINAL_VELOCITY))
	
	# Fall distance should be measured from when the player starts going down
	if sign(velocity.y) >= 0:
		_last_ground_y = global_position.y


func _handle_ground_physics(delta: float, wish_dir: Vector3) -> void:
	var friction := ground_friction
	
	# Come to a halt sooner if player stops moving
	if not wish_dir.x and not wish_dir.z:
		friction *= 2.0
	
	# Player accelerates to top speed
	velocity = velocity.lerp(wish_dir * get_move_speed(), friction * delta)


func get_move_speed() -> float:
	var speed := base_move_speed
	
	if is_sprinting or _was_sprinting_when_jumped:
		speed *= 1.4
	
	if is_crouched and is_on_floor():
		speed *= 0.5
	
	return speed


func _handle_footsteps(delta: float, input_dir: Vector2, grounded_status: int) -> void:
	floor_below_shape.force_shapecast_update()
	
	if not floor_below_shape.is_colliding():
		return
	
	var input_dir_normalised = input_dir.normalized()	
	var material = MaterialConfig.Keys.Concrete
	
	if floor_below_shape.get_collider(0) is MaterialBody:
		material = floor_below_shape.get_collider(0).material
	
	# Landing after jumping shakes the screen
	if grounded_status > 0:
		footstep_controller.play_footstep(material, true)
		_footstep_counter = 0.0
		var shake_strength: float = clampf(abs(min(global_position.y - _last_ground_y, 0.0)), 3, 13) * 0.1
		shake_screen(shake_strength, 25.0)
		EventsBus.player_landed_hard.emit(shake_strength)
		return
	
	# Don't play footsteps if walking into a wall but aren't actually moving
	if velocity == Vector3.ZERO:
		return
	
	# Clamp input_dir.length() to prevent footsteps from being too slow
	_footstep_counter += get_move_speed() * clampf(input_dir.length(), 0.4, 1.0) * delta

	# Player is moving around on the floor and it's time to take another step
	if is_on_floor() and input_dir_normalised and _footstep_counter > TIME_TO_NEXT_FOOTSTEP:
		footstep_controller.play_footstep(material, false)
		_footstep_counter = 0.0


func _check_for_npc() -> Npc:
	var collision_result: Dictionary = _cast_interaction_ray()
	
	if collision_result and collision_result.collider is Npc:
		return collision_result.collider
	
	return null


func _check_for_switch() -> SwitchBody:
	var collision_result: Dictionary = _cast_interaction_ray()
	
	if collision_result and collision_result.collider is SwitchBody:
		return collision_result.collider
	
	return null


## Projects a raycast from the camera straight ahead.
func _cast_interaction_ray() -> Dictionary:
	var to := camera.global_position + camera.project_ray_normal(get_viewport().get_visible_rect().size / 2) * INTERACT_DISTANCE
	var ray_params := PhysicsRayQueryParameters3D.create(camera.global_position, to)
	return get_world_3d().direct_space_state.intersect_ray(ray_params)


func _handle_controller_look_input(_delta: float) -> void:
	var target_look = Input.get_vector("look_left", "look_right", "look_down", "look_up")
	# Look speed is governed by how much the right analogue stick is moved
	var look_strength = sqrt(pow(target_look.x, 2.0) + pow(target_look.y, 2.0))
	_cur_controller_look = target_look
	
	if Input.is_action_pressed("zoom"):
		look_strength *= ZOOM_LOOK_STRENGTH_REDUCTION

	# Turn left and right
	rotate_y(-_cur_controller_look.x * controller_look_sensitivity * look_strength)

	# Look up and down
	camera.rotate_x(_cur_controller_look.y * controller_look_sensitivity * look_strength)
	camera.rotation.x = clamp(camera.rotation.x, -PI * 0.5, PI * 0.5)


func _handle_noclip(delta: float, input_dir: Vector2) -> bool:
	if Input.is_action_just_pressed("noclip"):# and OS.has_feature("debug"):
		noclipping = !noclipping
		noclip_speed_multiplier = NOCLIP_SPEED_MULTIPLIER_DEFAULT

	collision_shape.disabled = noclipping

	# If noclipping was turned off, stop here
	if not noclipping:
		return false

	update_wind_rushing_volume(0.0)

	var speed = get_move_speed() * noclip_speed_multiplier
	var vertical_speed: float = 0.0

	# Go faster when sprinting
	if Input.is_action_pressed("sprint"):
		speed *= noclip_speed_multiplier
	
	# Move up and down
	if Input.is_action_pressed("jump"):
		vertical_speed = 1.0
	elif Input.is_action_pressed("crouch"):
		vertical_speed = -1.0
	
	# Move based on camera orientation
	cam_aligned_wish_dir = camera.global_transform.basis * Vector3(input_dir.x, vertical_speed, input_dir.y)
	velocity = cam_aligned_wish_dir * speed
	global_position += velocity * delta
	_last_ground_y = global_position.y

	return true


func _set_reverb_parameters() -> void:
	var ray_count := room_size_rays.get_child_count()
	var room_size := 0.0
	var reflectiveness := 0.0
	var openness := 0.0

	for ray in room_size_rays.get_children():
		ray.force_raycast_update()

		if ray.is_colliding():
			var ray_dir = (ray.get_collision_point() - global_position).normalized()
			# Collision angle
			var col_dot = clampf(ray_dir.dot(ray.get_collision_normal()), -1.0, -0.2)
			# Length of colliding ray
			var distance = max(0.5, global_position.distance_to(ray.get_collision_point()))
			var material_props = {}
			
			# Default to concrete if unknown material encountered
			if ray.get_collider() is MaterialBody:
				if ray.get_collider().material == MaterialConfig.Keys.Empty:
					continue
				
				material_props = MaterialConfig.get_material_property(ray.get_collider().material)
			else:
				material_props = MaterialConfig.get_material_property(MaterialConfig.Keys.Concrete)
			
			# Longer rays means larger room
			room_size += distance
			# Stronger reflections if the collision was head on
			reflectiveness += material_props["reflect"] * abs(col_dot)
			openness += distance / MAX_REVERB_DISTANCE
			
			continue

		room_size += MAX_REVERB_DISTANCE
		openness += 1.0
		
		# Increase weight of up-facing rays for open-sky areas
		# Not totally realistic, but strengthens transitions into open spaces
		if "Up" in ray.name:
			openness += 1.67

	_norm_room_size = (room_size / ray_count - 1.0) / (MAX_REVERB_DISTANCE - 1.0)
	_norm_openness = clampf(openness / ray_count, 0.0, 1.0)
	_norm_reflectiveness = reflectiveness / ray_count

	# For dulling scene atmospherics when in closed spaces
	EventsBus.player_space_openness.emit(_norm_openness)

	# Reduce reverb wet mix the less reflective the environment is
	_target_room_size = _norm_room_size
	_target_damping = _norm_reflectiveness
	_target_predelay_feedback = (abs(_norm_openness - 1) * 0.25) + _norm_reflectiveness * 0.25
	_target_reverb_wet = abs(_norm_openness - 1) * 0.5

	# Check the environment at half the rate if space is mostly open
	if _norm_openness > 0.9:
		room_size_rays_timer.wait_time = 0.2
		_target_predelay_msec = 18.0
	else:
		room_size_rays_timer.wait_time = 0.1
		# This was mostly guesswork, somehow it kind of works
		_target_predelay_msec = clampf((room_size / ray_count * 8.2) * (_norm_room_size + 1), 10.0, 300.0)


func _update_reverb_system(delta: float) -> void:
	# Prevent room size ray casts from turning
	room_size_rays.global_rotation = Vector3.ZERO

	var room_size = AudioServer.get_bus_effect(_reverb_bus, 0).room_size
	var damping = AudioServer.get_bus_effect(_reverb_bus, 0).damping
	var predelay_msec = AudioServer.get_bus_effect(_reverb_bus, 0).predelay_msec
	var predelay_feedback = AudioServer.get_bus_effect(_reverb_bus, 0).predelay_feedback
	var reverb_wet = AudioServer.get_bus_effect(_reverb_bus, 0).wet

	# Ensure reverb parameter settings transition smoothly with changes
	room_size = lerp(room_size, _target_room_size, 5.0 * delta)
	damping = lerp(damping, _target_damping, 5.0 * delta)
	predelay_msec = lerp(predelay_msec, _target_predelay_msec, 5.0 * delta)
	predelay_feedback = lerp(predelay_feedback, _target_predelay_feedback, 5.0 * delta)
	reverb_wet = lerp(reverb_wet, _target_reverb_wet, 5.0 * delta)

	# Apply reverb parameters
	AudioServer.get_bus_effect(_reverb_bus, 0).room_size = room_size
	AudioServer.get_bus_effect(_reverb_bus, 0).damping = damping
	AudioServer.get_bus_effect(_reverb_bus, 0).predelay_msec = predelay_msec
	AudioServer.get_bus_effect(_reverb_bus, 0).predelay_feedback = predelay_feedback
	AudioServer.get_bus_effect(_reverb_bus, 0).wet = reverb_wet


## Create raycasts that the dynamic reverb system uses to check the environment.
func _generate_raycasts(ray_count: int, max_distance: float) -> void:
	for ray in room_size_rays.get_children():
		if not ray.name in ["Up", "Down"]:
			ray.queue_free()

	var directions = _generate_geodesic_directions(ray_count)
	var up_facing := 0

	for direction in directions:
		var new_ray = RayCast3D.new()
		room_size_rays.add_child(new_ray)
		new_ray.target_position = direction * max_distance
		
		var dir_to_ray = global_position.direction_to(new_ray.target_position)

		if dir_to_ray.dot(Vector3.UP) > 0.67:
			up_facing += 1
			new_ray.name = "Up" + str(up_facing)
			new_ray.debug_shape_custom_color = Color(1.0, 0.0, 1.0)


## Generate directions projected on a sphere in a spiral pattern pointing outwards.
func _generate_geodesic_directions(direction_count: int) -> Array:
	var directions = []
	# Golden ratio
	var phi = (1 + sqrt(5)) * 0.5

	for i in range(direction_count):
		# Calculate azimuthal angle
		var theta = 2 * PI * i / phi
		var z = 1 - 2 * i / float(direction_count)
		var radius = sqrt(1 - z * z)
		var x = radius * cos(theta)
		var y = radius * sin(theta)

		directions.append(Vector3(x, y, z).normalized())

	return directions


## Hides all interaction icons and shows the one stated.
func _show_crosshair_icon(icon_name: String) -> void:
	for child in crosshair.get_children():
		if child.name == icon_name:
			child.show()
			continue
		
		child.hide()


## Exposes the player to rushing wind when they move fast enough in any direction.
func _player_falling_wind_rushing() -> void:
	# The faster the player is moving, the more wind rushing they hear
	var fall_rate = (velocity.length() - WIND_RUSH_MIN_VELOCITY) / (abs(TERMINAL_VELOCITY) - WIND_RUSH_MIN_VELOCITY)
	update_wind_rushing_volume(clampf(fall_rate, 0.0, 1.0))


func _on_wind_rushing_sfx_finished() -> void:
	wind_rushing_sfx.play()


func _handle_respawn() -> void:
	# Hold respawn button to reset position but require releasing the button to trigger again
	if Input.is_action_pressed("respawn") and not _just_respawned:
		_respawn_hold_counter += 1

		if _respawn_hold_counter > HOLD_TIME_FOR_RESPAWN:
			respawn_player()
			_respawn_hold_counter = 0
			_just_respawned = true

	# Reset counter if respawn button released before threshold reached
	if not Input.is_action_pressed("respawn"):
		_respawn_hold_counter = 0
		_just_respawned = false


func kill_player() -> void:
	EventsBus.player_died.emit()
	velocity = Vector3.ZERO
	head.rotation_degrees.z = 0.0
	_shake_strength = 0.0
	update_wind_rushing_volume(0.0)
	death_sfx.play()
	_player_is_dead = true


func respawn_player() -> void:
	EventsBus.player_respawned.emit()
	velocity = Vector3.ZERO
	head.rotation_degrees.z = 0.0
	_shake_strength = 0.0
	update_wind_rushing_volume(0.0)
	global_position = respawn_position
	global_rotation = respawn_orientation
	_last_ground_y = respawn_position.y
	camera.fov = base_camera_fov
	camera.rotation.x = 0.0
	_player_is_dead = false


func freeze_player(is_frozen: bool) -> void:
	if not _player_can_interact:
		return
	
	_player_is_frozen = is_frozen


## Initiate a screen shake.
func shake_screen(strength: float, speed: float) -> void:
	_shake_strength = strength
	_shake_speed = speed


## Calculate how much shake to apply based on the given parameters.
func screen_shake_decay(delta: float, decay_rate: float) -> Vector2:
	_shake_strength = lerp(_shake_strength, 0.0, decay_rate * delta)
	_noise_i += delta * _shake_speed

	return Vector2(
		noise.get_noise_2d(1, _noise_i) * _shake_strength,
		noise.get_noise_2d(100, _noise_i) * _shake_strength
	)


func update_wind_rushing_volume(value: float) -> void:
	wind_rushing_sfx.volume_db = linear_to_db(value)


func show_torch() -> void:
	torch.show()


func is_torch_visible() -> bool:
	return torch.visible


func unfreeze_player() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	interact_delay_timer.start()
	_player_is_frozen = false


func update_mouse_look_sensitivity(value: float) -> void:
	if value < 2.0 or value > 8.0: return

	look_sensitivity = value * 0.001


func update_controller_look_sensitivity(value: float) -> void:
	if value < 2.0 or value > 8.0: return

	controller_look_sensitivity = (value * 0.01) - 0.01


func update_camera_fov(value: float) -> void:
	base_camera_fov = value
	camera.fov = value


## Delays next interaction after previous one has ended.
func _on_interact_delay_timer_timeout() -> void:
	_player_can_interact = true
