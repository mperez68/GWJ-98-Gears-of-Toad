class_name Util extends RefCounted

enum Facing{ NORTH, EAST, SOUTH, WEST }
enum RotateIncrement{ LEFT = -1, RIGHT = 1, FLIP = 2 }
const FACING_MAP: Dictionary[Facing, Vector3i] = {
	Facing.NORTH: Vector3i.FORWARD, 
	Facing.EAST: Vector3i.RIGHT,
	Facing.SOUTH: Vector3i.BACK,
	Facing.WEST: Vector3i.LEFT,
}

const EXIT_NODE_KEY: String = "exit_nodes"
const FROG_NODE_KEY: String = "frogs"

static func get_facing_vector(facing: Facing) -> Vector3i:
	return FACING_MAP[facing] if FACING_MAP.has(facing) else FACING_MAP[Facing.NORTH]

static func grid_to_position(grid_position: Vector3i, grid_size: Vector3) -> Vector3:
	if grid_size.x == 0 or grid_size.y == 0 or grid_size.z == 0:
		printerr("grid size is invalid (cannot divide by 0)!")
		return Vector3.ZERO
	var ret: Vector3 = Vector3(grid_position) * grid_size
	ret += grid_size / 2
	return ret

static func position_to_grid(position: Vector3, grid_size: Vector3) -> Vector3i:
	if grid_size.x == 0 or grid_size.y == 0 or grid_size.z == 0:
		printerr("grid size is invalid (cannot divide by 0)!")
		return Vector3i.ZERO
	var ret = Vector3i.ZERO
	ret.x = floor(position.x / grid_size.x)
	ret.y = floor(position.y / grid_size.y)
	ret.z = floor(position.z / grid_size.z)
	return ret
