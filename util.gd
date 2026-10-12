class_name Util extends RefCounted

enum Facing{ NORTH, EAST, SOUTH, WEST }
const FACING_MAP: Dictionary[Facing, Vector3i] = {
	Facing.NORTH: Vector3i.LEFT,
	Facing.EAST: Vector3i.FORWARD, 
	Facing.SOUTH: Vector3i.RIGHT,
	Facing.WEST: Vector3i.BACK,
}

static func get_facing_vector(facing: Facing) -> Vector3i:
	return FACING_MAP[facing] if FACING_MAP.has(facing) else FACING_MAP[Facing.NORTH]
