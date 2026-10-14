@tool
class_name FrogNode extends GridNode3D

signal color_changed(new_color: Color)

@export var color: Color = Color.FIREBRICK:
	set(value):
		color = value
		color_changed.emit(color)
@export var leap_distance: int = 1


# ENGINE
func _ready():
	super()
	color = color
	facing = facing


# PUBLIC
func move_stage(game_board_node: GameBoardNode):
	grid_position = game_board_node.get_leap_position(self)

func fall_stage(game_board_node: GameBoardNode):
	grid_position = game_board_node.get_fall_position(self)

func cleanup_stage(game_board_node: GameBoardNode):
	if game_board_node.kills_frog(grid_position):
		kill()
	for node in get_tree().get_nodes_in_group(Util.EXIT_NODE_KEY):
		if node.grid_position == grid_position:
			kill()
			print("Redeem!")

func turn(increment: Util.RotateIncrement):
	var ret: int = facing + increment
	while ret < 0:
		ret += Util.Facing.size()
	facing = (ret % Util.Facing.size()) as Util.Facing

func kill():
	queue_free()


# PRIVATE


# SIGNALS
