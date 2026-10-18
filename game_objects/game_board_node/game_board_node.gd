@tool
class_name GameBoardNode extends GridMap

## Maximum number of characters that can be used by id hashing.
const MAX_COORDINATE_SIZE: int = 3
## Number of empty tiles required vertically over an occupied terrain cell to be walkable.
const VERTICAL_CLEARANCE: int = 2
## Maximum height between tiles for a frog to jump up the distance vertically.
const JUMP_HEIGHT: int = 1
const INVISIBLE_ITEM_INDEX: int = 1

#var nav: AStar3D
var _cached_cells: Array[Vector3i]
var _y_floor: int = INT64_MAX

@export_group("Debug")
@export var test_position: Vector3i:
	set(value):
		test_position = value


# ENGINE
func _ready() -> void:
	if !Engine.is_editor_hint():
		SignalBus.set_invisible_tile.connect(_on_set_invisible_tile)


# PUBLIC
func get_cells(force_refresh: bool = false) -> Array[Vector3i]:
	if _cached_cells.is_empty() or force_refresh:
		_cached_cells = get_used_cells()
		_y_floor = INT64_MAX
	return _cached_cells

func get_y_floor(force_refresh: bool = false) -> int:
	if _y_floor == INT64_MAX or force_refresh:
		_y_floor = INT64_MAX
		for cell in get_cells(true):
			_y_floor = min(cell.y, _y_floor)
	return _y_floor

func can_stand(pos: Vector3i) -> bool:
	if !get_cells().has(pos + Vector3i.DOWN):
		return false
	return !is_blocked(pos)

func is_blocked(pos: Vector3i) -> bool:
	for vert_offset in range(0, VERTICAL_CLEARANCE):
		if get_cells().has(pos + Vector3i(0, vert_offset, 0)):
			return true
	return false

func get_leap_position(frog: FrogNode) -> Vector3i:
	var ret = frog.grid_position + Vector3i(0, JUMP_HEIGHT, 0) + (Util.get_facing_vector(frog.facing) * frog.leap_distance)
	if is_blocked(ret):
		ret = frog.grid_position if is_blocked(frog.grid_position + Vector3i.UP) else (frog.grid_position + Vector3i.UP)
	return ret

func get_fall_position(frog: FrogNode) -> Vector3i:
	var ret = frog.grid_position
	while !can_stand(ret):
		ret += Vector3i.DOWN
		if ret.y <= get_y_floor():
			return ret + (Vector3i.DOWN * 8)
	return ret

func kills_frog(pos: Vector3i) -> bool:
	return pos.y <= get_y_floor()


# PRIVATE


# SIGNALS
func _on_set_invisible_tile(pos: Vector3i):
	set_cell_item(pos, INVISIBLE_ITEM_INDEX)
