@tool
class_name ColorMesh extends Node3D

@onready var omni_light_3d: OmniLight3D = %OmniLight3D

var color: Color = Color.WHITE:
	set(value):
		color = value
		if omni_light_3d:
			omni_light_3d.light_color = color


# ENGINE
func _ready() -> void:
	omni_light_3d.light_color = color


# PUBLIC


# PRIVATE


# SIGNALS
func _on_frog_node_color_changed(new_color: Color) -> void:
	color = new_color
