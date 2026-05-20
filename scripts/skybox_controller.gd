@tool
class_name SkyboxController
extends WorldEnvironment


@onready var sun: DirectionalLight3D = $"../Sun"


func _process(_delta: float) -> void:
	# This is our forward direction pointing towards the sun
	var sun_dir = sun.get_global_transform().basis.z
	
	# Update sky material with sun direction
	environment.sky.sky_material.set_shader_parameter('sun_dir', sun_dir)
