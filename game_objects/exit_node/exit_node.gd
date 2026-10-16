@tool
class_name ExitNode extends ColoredGridNode


# ENGINE
func _ready():
	super()
	if !Engine.is_editor_hint():
		SignalBus.set_invisible_tile.emit(grid_position + Vector3i.DOWN)


# PUBLIC
func cleanup_stage(_game_board_node: GameBoardNode):
	for node in get_tree().get_nodes_in_group(Util.FROG_NODE_KEY):
		if node.grid_position == grid_position and is_frog_compatible(node):
			SignalBus.frog_scored.emit(node.frog_type)
			node.kill()	# TODO fall through chute


# PRIVATE


# SIGNALS
