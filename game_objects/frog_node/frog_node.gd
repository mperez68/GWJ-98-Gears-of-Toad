@tool
class_name FrogNode extends ColoredGridNode

@export var leap_distance: int = 1

# ENGINE
func _ready():
	super()
	facing = facing


# PUBLIC
func move_stage(game_board_node: GameBoardNode):
	grid_position = game_board_node.get_leap_position(self)

func fall_stage(game_board_node: GameBoardNode):
	grid_position = game_board_node.get_fall_position(self)

func cleanup_stage(game_board_node: GameBoardNode):
	if game_board_node.kills_frog(grid_position):
		kill()

func turn(increment: Util.RotateIncrement):
	var ret: int = facing + increment
	while ret < 0:
		ret += Util.Facing.size()
	facing = (ret % Util.Facing.size()) as Util.Facing

func kill():
	queue_free()


# PRIVATE


# SIGNALS
func _on_frog_collider_collision_occurred() -> void:
	kill()
