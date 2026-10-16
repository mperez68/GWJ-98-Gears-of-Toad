@tool
class_name ObstacleNode extends GridNode3D


# ENGINE
func _ready():
	super()
	if !Engine.is_editor_hint():
		SignalBus.set_invisible_tile.emit(grid_position)
		SignalBus.set_invisible_tile.emit(grid_position + Util.get_facing_vector(facing))
		SignalBus.set_invisible_tile.emit(grid_position + Vector3i.UP)
		SignalBus.set_invisible_tile.emit(grid_position + Util.get_facing_vector(facing) + Vector3i.UP)


# PUBLIC


# PRIVATE


# SIGNALS
