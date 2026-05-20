@tool # Make it run in editor (might need to close and reopen scene to work)
class_name SkyboxController
extends WorldEnvironment # We're modifying the sky material that is on a WorldEnvironment, so extend from there.


@onready var sun: DirectionalLight3D = $"../Sun"


func _process(_delta: float) -> void:
	# This is our forward direction pointing towards the sun
	var sun_dir = sun.get_global_transform().basis.z
	
	# Update sky material with sun direction
	environment.sky.sky_material.set_shader_parameter('sun_dir', sun_dir)
