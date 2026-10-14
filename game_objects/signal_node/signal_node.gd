@tool
class_name SignalNode extends GridNode3D


# ENGINE
func place_stage(_game_board_node: GameBoardNode):
	for node in get_tree().get_nodes_in_group(Util.FROG_NODE_KEY):
		if grid_position == node.grid_position and node is FrogNode:
			node.turn(Util.RotateIncrement.LEFT)


# PUBLIC


# PRIVATE


# SIGNALS
