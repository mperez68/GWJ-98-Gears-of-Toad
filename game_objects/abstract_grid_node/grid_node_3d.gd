@tool
class_name GridNode3D extends Node3D

const SOFT_TOLERANCE: float = 0.1
const HARD_TOLERANCE: float = 5.0
const TWEEN_SPEED: float = 8.0

signal moved

## The position on the grid of this node.
@export var grid_position: Vector3i = Vector3i.ZERO:
	set(value):
		grid_position = value
		if Engine.is_editor_hint():
			var new_pos: Vector3 = Util.grid_to_position(grid_position, grid_size)
			if position != new_pos:
				position = new_pos
		moved.emit()
@export var facing: Util.Facing:
	set(value):
		facing = value
		if is_node_ready():
			look_at(position + Vector3(Util.get_facing_vector(facing)))
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
	position = Util.grid_to_position(grid_position, grid_size)

func _notification(what):
	if what == NOTIFICATION_TRANSFORM_CHANGED and snap_to_grid:
		_center()

func _process(delta: float) -> void:
	var new_pos: Vector3 = Util.grid_to_position(grid_position, grid_size)
	if position.distance_to(new_pos) < SOFT_TOLERANCE and position != new_pos:
		position = new_pos
	elif position.distance_to(new_pos) > HARD_TOLERANCE:
		position = new_pos
	else:
		position = position.move_toward(new_pos, TWEEN_SPEED * delta)


# PUBLIC
func move_stage(_game_board_node: GameBoardNode):
	pass

func fall_stage(_game_board_node: GameBoardNode):
	pass

func place_stage(_game_board_node: GameBoardNode):
	pass

func cleanup_stage(_game_board_node: GameBoardNode):
	pass


# PRIVATE
func _center():
	grid_position = Util.position_to_grid(position, grid_size)


# SIGNALS
