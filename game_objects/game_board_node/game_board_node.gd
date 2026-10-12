@tool
class_name GameBoardNode extends GridMap

## Maximum number of characters that can be used by id hashing.
const MAX_COORDINATE_SIZE: int = 3
## Number of empty tiles required vertically over an occupied terrain cell to be walkable.
const VERTICAL_CLEARANCE: int = 2
## Maximum height between tiles for a frog to jump up the distance vertically.
const JUMP_HEIGHT: int = 1

#var nav: AStar3D
var _cached_cells: Array[Vector3i]
var _y_floor: int = INT64_MAX

@export_group("Debug")
@export var test_position: Vector3i:
	set(value):
		test_position = value
		_print_debug()

@warning_ignore("unused_private_class_variable")
@export_tool_button("print", "3D") var _test = _print_debug

func _print_debug():
	print("\n%s :: %s" % [test_position, can_stand(test_position)])
	print(Util.get_facing_vector(Util.Facing.NORTH), " == ", can_jump(test_position, Util.Facing.NORTH))
	print(Util.get_facing_vector(Util.Facing.EAST), " == ",can_jump(test_position, Util.Facing.EAST))
	print(Util.get_facing_vector(Util.Facing.SOUTH), " == ",can_jump(test_position, Util.Facing.SOUTH))
	print(Util.get_facing_vector(Util.Facing.WEST), " == ",can_jump(test_position, Util.Facing.WEST))


# ENGINE


# PUBLIC
func get_cells(force_refresh: bool = false) -> Array[Vector3i]:
	if _cached_cells.is_empty() or force_refresh:
		_cached_cells = get_used_cells()
		_y_floor = INT64_MAX
	return _cached_cells

func get_y_floor(force_refresh: bool = false) -> int:
	if _y_floor == INT64_MAX or force_refresh:
		for cell in get_cells(true):
			_y_floor = INT64_MAX
			_y_floor = min(cell.y, _y_floor)
	return _y_floor

func can_stand(pos: Vector3i) -> bool:
	if !get_cells().has(pos + Vector3i.DOWN):
		return false
	for vert_offset in range(0, VERTICAL_CLEARANCE):
		if get_cells().has(pos + Vector3i(0, vert_offset, 0)):
			return false
	return true

func can_jump(start: Vector3i, facing: Util.Facing) -> bool:
	for v_offset in range(JUMP_HEIGHT, -JUMP_HEIGHT - 1, -1):
		if can_stand(start + Vector3i(0, v_offset, 0) + Util.get_facing_vector(facing)):
			return true
	return false


# PRIVATE


# SIGNALS
