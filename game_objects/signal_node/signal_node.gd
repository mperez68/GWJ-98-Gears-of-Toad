@tool
class_name SignalNode extends ColoredGridNode

signal signal_type_changed(new_type: SignalType)

@export var signal_type: SignalType:
	set(value):
		signal_type = value
		signal_type_changed.emit(signal_type)


# ENGINE
func place_stage(_game_board_node: GameBoardNode):
	for node in get_tree().get_nodes_in_group(Util.FROG_NODE_KEY):
		if grid_position == node.grid_position and is_frog_compatible(node):
			if signal_type:
				signal_type.do(node)


# PUBLIC


# PRIVATE


# SIGNALS
func _on_signal_type_changed(new_type: SignalType) -> void:
	scale = Vector3.ONE if new_type else Vector3(0.5, 0.5, 0.5)
