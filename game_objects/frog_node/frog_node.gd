@tool
class_name FrogNode extends Node3D

@export var facing: Util.Facing:
	set(value):
		facing = value
		look_at(position + Vector3(Util.get_facing_vector(facing)))


# ENGINE


# PUBLIC


# PRIVATE


# SIGNALS
