@tool
class_name SignalNode extends ColoredGridNode

@export var signal_type: SignalType


# ENGINE
func place_stage(_game_board_node: GameBoardNode):
	for node in get_tree().get_nodes_in_group(Util.FROG_NODE_KEY):
		if grid_position == node.grid_position and is_frog_compatible(node):
			if signal_type:
				signal_type.do(node)


# PUBLIC


# PRIVATE


# SIGNALS
