class_name MaterialConfig
## Defines materials and their reflectiveness. Used for dynamic reverb and
## footsteps.


enum Keys {
	Concrete,
	MetalDull,
	MetalHollow,
	Sand,
	Cloth,
	Empty,
}

static var properties := {
	Keys.Concrete: {
		"reflect": 0.7,
	},
	Keys.MetalDull: {
		"reflect": 0.6,
	},
	Keys.MetalHollow: {
		"reflect": 0.7,
	},
	Keys.Sand: {
		"reflect": 0.0,
	},
	Keys.Cloth: {
		"reflect": 0.4,
	},
	Keys.Empty: {
		"reflect": 0.0,
	},
}


static func get_material_property(key: Keys) -> Dictionary:
	return properties[key]
