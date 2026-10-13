@tool
class_name ColorMesh extends CSGSphere3D

var color: Color = Color.WHITE:
	set(value):
		color = value
		if material and material is StandardMaterial3D:
			material.albedo_color = color


# ENGINE


# PUBLIC


# PRIVATE


# SIGNALS


func _on_frog_node_color_changed(new_color: Color) -> void:
	color = new_color
