class_name LevelConfig


enum Keys {
	TestLevel,
}

const LEVEL_PATHS := {
	Keys.TestLevel: "res://scenes/levels/lvl_test.tscn",
}


static func get_level(key: Keys) -> Node:
	return load(LEVEL_PATHS.get(key)).instantiate()


static func get_level_path(key: Keys) -> String:
	return LEVEL_PATHS.get(key)
