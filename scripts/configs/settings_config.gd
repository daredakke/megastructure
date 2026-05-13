class_name SettingsConfig
extends Node


static var resolutions: Array[Dictionary] = [
	{
		"string": "1280x720",
		"vector": Vector2i(1280, 720),
		"aspect": "16:9"
	},
	{
		"string": "1280x800",
		"vector": Vector2i(1280, 800),
		"aspect": "8:5"
	},
	{
		"string": "1366x768",
		"vector": Vector2i(1366, 768),
		"aspect": "16:9"
	},
	{
		"string": "1440x900",
		"vector": Vector2i(1440, 900),
		"aspect": "8:5"
	},
	{
		"string": "1600x900",
		"vector": Vector2i(1600, 900),
		"aspect": "16:9"
	},
	{
		"string": "1920x1080",
		"vector": Vector2i(1920, 1080),
		"aspect": "16:9"
	},
	{
		"string": "1920x1200",
		"vector": Vector2i(1920, 1200),
		"aspect": "8:5"
	},
	{
		"string": "2560x1440",
		"vector": Vector2i(2560, 1440),
		"aspect": "16:9"
	},
	{
		"string": "2560x1600",
		"vector": Vector2i(2560, 1600),
		"aspect": "8:5"
	},
	{
		"string": "3840x2160",
		"vector": Vector2i(3840, 2160),
		"aspect": "16:9"
	},
]


## Get the array index associated with a given resolution string
static func get_resolution_idx(resolution_string: String) -> int:
	var counter: int = 0
	
	for res in resolutions:
		if resolution_string == res["string"]:
			return counter
		
		counter += 1
	
	return 0


## Get the resolution string for its associated array index
static func get_resolution_string(idx: int) -> String:
	return resolutions[idx]["string"]


## Get the resolution vector for its associated array index
static func get_resolution_vector(idx: int) -> Vector2i:
	return resolutions[idx]["vector"]
