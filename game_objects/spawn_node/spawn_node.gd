@tool
class_name SpawnNode extends GridNode3D

const FROG: PackedScene = preload("res://game_objects/frog_node/frog_node.tscn")


# ENGINE


# PUBLIC
func place_stage(_game_board_node: GameBoardNode):
	var new_frog: FrogNode = FROG.instantiate()
	new_frog.grid_position = grid_position
	new_frog.facing = facing
	add_sibling(new_frog)


# PRIVATE


# SIGNALS
