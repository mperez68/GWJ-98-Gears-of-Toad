@tool
class_name GridNode3D extends Node3D

signal moved

## The position on the grid of this node.
@export var grid_position: Vector3i = Vector3i.ZERO:
	set(value):
		grid_position = value
		var new_pos: Vector3 = Util.grid_to_position(grid_position, grid_size)
		if position != new_pos:
			position = new_pos
		moved.emit()
@export_group("Editor")
@export var snap_to_grid: bool = true:
	set(value):
		snap_to_grid = value
		if snap_to_grid and Engine.is_editor_hint():
			_center()
@export var grid_size: Vector3 = Vector3(2.0, 0.5, 2.0)


# ENGINE
func _ready():
	if Engine.is_editor_hint():
		set_notify_transform(true)
	grid_position = grid_position

func _notification(what):
	if what == NOTIFICATION_TRANSFORM_CHANGED and snap_to_grid:
		_center()


# PUBLIC


# PRIVATE
func _center():
	grid_position = Util.position_to_grid(position, grid_size)


# SIGNALS
