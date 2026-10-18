@tool
class_name ExitNode extends ColoredGridNode

signal chute_opened
signal chute_closed

# ENGINE
func _ready():
	super()
	if !Engine.is_editor_hint():
		SignalBus.set_invisible_tile.emit(grid_position + Vector3i.DOWN)


# PUBLIC
func place_stage(_game_board_node: GameBoardNode):
	for node in get_tree().get_nodes_in_group(Util.FROG_NODE_KEY):
		if node.grid_position == grid_position and is_frog_compatible(node):
			node.grid_position += Vector3i.DOWN * 3
			chute_opened.emit()
	

func cleanup_stage(_game_board_node: GameBoardNode):
	for node in get_tree().get_nodes_in_group(Util.FROG_NODE_KEY):
		if node.grid_position == grid_position + (Vector3i.DOWN * 3) and is_frog_compatible(node):
			chute_closed.emit()
			SignalBus.frog_scored.emit(node.frog_type)
			node.queue_free()


# PRIVATE


# SIGNALS
