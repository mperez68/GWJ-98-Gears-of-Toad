@tool
class_name CsgCylinder3d extends CSGCylinder3D

@onready var omni_light_3d: OmniLight3D = %OmniLight3D

var color: Color = Color.WHITE:
	set(value):
		color = value
		_color_changed()


# ENGINE
func _ready() -> void:
	omni_light_3d.light_color = color


# PUBLIC


# PRIVATE
func _color_changed():
	if omni_light_3d:
		omni_light_3d.light_color = color
	material.albedo_color = color


# SIGNALS
func _on_node_color_changed(new_color: Color) -> void:
	color = new_color
