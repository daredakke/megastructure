class_name MusicController
extends Node


var _tracks: Array[AudioStreamPlayer] = []
var _next_track: int = 0

@onready var music_timer: Timer = $MusicTimer


func _ready() -> void:
	EventsBus.music_started.connect(_on_track_finished)
	
	for node in get_children():
		if node is AudioStreamPlayer:
			_tracks.push_back(node)
	
	_tracks.shuffle()


func _on_music_timer_timeout() -> void:
	_tracks[_next_track].play()
	
	_next_track += 1
	
	if _next_track >= _tracks.size():
		_next_track = 0


func _on_track_finished() -> void:
	music_timer.start()
