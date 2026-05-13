class_name LevelController
extends Node


var _next_scene = null
var _spawn_location: String = ""
var _torch_is_on: bool = false

@export var initial_scene: LevelConfig.Keys
@export var initial_spawn: String = "Start"


func _ready() -> void:
	EventsBus.scene_changed.connect(change_scene)
	
	change_scene(initial_scene, initial_spawn, false)


func _process(_delta: float) -> void:
	if _next_scene == null: return
	
	if ResourceLoader.load_threaded_get_status(_next_scene) == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene = ResourceLoader.load_threaded_get(_next_scene).instantiate()
		
		add_child(new_scene)
		new_scene.spawn_player(_spawn_location, _torch_is_on)
		_next_scene = null
		EventsBus.loading_screen_hidden.emit()


func change_scene(key: LevelConfig.Keys, spawn_location: String, torch_is_on: bool) -> void:
	for child in get_children():
		child.queue_free()
	
	_spawn_location = spawn_location
	_torch_is_on = torch_is_on
	_next_scene = LevelConfig.get_level_path(key)
	ResourceLoader.load_threaded_request(_next_scene)
	EventsBus.loading_screen_shown.emit()
