@tool
class_name WallSprite
extends Sprite3D


const RAY_LENGTH := 1000.0
const FRAME_BACK := 0.1
const FRAME_FRONT := 0.4
const FRAME_BORDER := 1.0
const PICTURE_FRAME_MATERIAL := preload("uid://bm3hyx3nivao")

@export_tool_button("Place Against Wall") var place_button := place_against_surface
@export_range(0.01, 2.0, 0.01) var picture_scale: float = scale.x:
	set(new_scale):
		picture_scale = new_scale
		scale = Vector3(picture_scale, picture_scale, picture_scale)


func _ready() -> void:
	#if Engine.is_editor_hint():
		#EditorInterface.get_inspector().property_edited.connect(_on_property_changed)
	
	if texture != null:
		add_picture_frame()


func place_against_surface() -> void:
	var ray_end = global_position - global_basis.z * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(global_position, ray_end)
	var result = get_world_3d().direct_space_state.intersect_ray(query)

	if not result:
		return
	
	global_position = result.position + result.normal * 0.05

	# Rotate the node so its back (-z) faces the surface normal
	look_at(result.position + result.normal, Vector3.UP)
	rotate_y(TAU * 0.5)


func add_picture_frame() -> void:
	for child in get_children():
		child.queue_free()
	
	if ResourceLoader.exists("res://scenes/geometry/generated/%s_frame.tscn" % name):
		add_child(load("res://scenes/geometry/generated/%s_frame.tscn" % name).instantiate())
		#print("Added for %s" % name)


func generate_picture_frame() -> void:
	# Remove any existing picture frame instances
	for child in get_children():
		child.queue_free()
	
	# Remove any existing picture frames
	if ResourceLoader.exists("res://scenes/geometry/generated/%s_frame.tscn" % name):
		DirAccess.remove_absolute("res://scenes/geometry/generated/%s_frame.tscn" % name)
	
	if texture == null:
		return
	
	var width := texture.get_width() * 0.01
	var height := texture.get_height() * 0.01
	var verts := {
		"BLR": Vector3(-FRAME_BORDER, -FRAME_BORDER, -FRAME_BACK),
		"BRR": Vector3(width + FRAME_BORDER, -FRAME_BORDER, -FRAME_BACK),
		"TLR": Vector3(-FRAME_BORDER, height + FRAME_BORDER, -FRAME_BACK),
		"TRR": Vector3(width + FRAME_BORDER, height + FRAME_BORDER, -FRAME_BACK),
		"BLF": Vector3(-FRAME_BORDER, -FRAME_BORDER, FRAME_FRONT),
		"BRF": Vector3(width + FRAME_BORDER, -FRAME_BORDER, FRAME_FRONT),
		"TLF": Vector3(-FRAME_BORDER, height + FRAME_BORDER, FRAME_FRONT),
		"TRF": Vector3(width + FRAME_BORDER, height + FRAME_BORDER, FRAME_FRONT),
		"BLI": Vector3(0, 0, 0),
		"BRI": Vector3(width, 0, 0),
		"TLI": Vector3(0, height, 0),
		"TRI": Vector3(width, height, 0),
	}
	
	# Back
	var vertices := PackedVector3Array([verts["BLR"], verts["TLR"], verts["BRR"], verts["TRR"],])
	var normals = _get_normal_array(Vector3.FORWARD)
	var uvs = PackedVector2Array([
		Vector2(0, 0),
		Vector2(1, 0),
		Vector2(0, 1),
		Vector2(1, 1),
	])
	var indices = PackedInt32Array([
		0, 2, 1, # Draw the first triangle.
		2, 3, 1, # Draw the second triangle.
	])
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_TEX_UV2] = uvs
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_INDEX] = indices
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	# Up
	vertices = PackedVector3Array([verts["TRR"], verts["TLR"], verts["TRF"], verts["TLF"]])
	normals = _get_normal_array(Vector3.UP)
	
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	# Down
	vertices = PackedVector3Array([verts["BLR"], verts["BRR"], verts["BLF"], verts["BRF"]])
	normals = _get_normal_array(Vector3.DOWN)
	
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	# Right
	vertices = PackedVector3Array([verts["BLF"], verts["TLF"], verts["BLR"], verts["TLR"]])
	normals = _get_normal_array(Vector3.LEFT)
	
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	# Left
	vertices = PackedVector3Array([verts["BRR"], verts["TRR"], verts["BRF"], verts["TRF"]])
	normals = _get_normal_array(Vector3.RIGHT)
	
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	# Front upper
	vertices = PackedVector3Array([verts["TLI"], verts["TRI"], verts["TLF"], verts["TRF"]])
	normals = _get_normal_array((verts["TRI"] - verts["TLI"]).cross(verts["TLF"] - verts["TRI"]))
	
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	# Front lower
	vertices = PackedVector3Array([verts["BLF"], verts["BRF"], verts["BLI"], verts["BRI"]])
	normals = _get_normal_array((verts["BRF"] - verts["BLF"]).cross(verts["BLI"] - verts["BLF"]))
	
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	# Front left
	vertices = PackedVector3Array([verts["BLF"], verts["BLI"], verts["TLF"], verts["TLI"]])
	normals = _get_normal_array((verts["BLI"] - verts["BLF"]).cross(verts["TLF"] - verts["BLF"]))
	
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	# Front right
	vertices = PackedVector3Array([verts["BRI"], verts["BRF"], verts["TRI"], verts["TRF"]])
	normals = _get_normal_array((verts["BRF"] - verts["BRI"]).cross(verts["TRI"] - verts["BRI"]))
	
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	var new_mesh := MeshInstance3D.new()
	
	new_mesh.name = "PictureFrame"
	new_mesh.mesh = arr_mesh
	
	# Set up node hierarchy
	var body := MaterialBody.new()
	
	add_child(body)
	body.name = "%sFrame" % name
	body.owner = self
	body.material = MaterialConfig.Keys.Cloth
	
	body.add_child(new_mesh)
	new_mesh.owner = body
	new_mesh.position.x = -width * 0.5
	new_mesh.position.y = -height * 0.5
	new_mesh.material_override = PICTURE_FRAME_MATERIAL
	
	var collision := CollisionShape3D.new()
	var box := BoxShape3D.new()
	
	box.size = Vector3(width + FRAME_BORDER * 2, height + FRAME_BORDER * 2, FRAME_FRONT * 2)
	collision.shape = box
	
	body.add_child(collision)
	collision.owner = body
	
	var packed_scene := PackedScene.new()
	packed_scene.pack(body)
	
	ResourceSaver.save(packed_scene, "res://scenes/geometry/generated/%s_frame.tscn" % name)
	EditorInterface.get_resource_filesystem().scan()
	#print("Generated for %s" % name)
	
	add_picture_frame()


func _get_normal_array(vec: Vector3) -> PackedVector3Array:
	return PackedVector3Array([vec, vec, vec, vec])


#func _on_property_changed(property: String) -> void:
	#if property == "texture":
		##var edited_object = EditorInterface.get_inspector().get_edited_object()
		#
		#generate_picture_frame()
		#add_picture_frame()
