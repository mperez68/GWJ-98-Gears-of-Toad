@tool
class_name FrogNode extends ColoredGridNode

signal start_windup
signal start_move
signal start_fall
signal start_idle
signal died

@onready var death_timer: Timer = %DeathTimer

@export var leap_distance: int = 1

var dead: bool = false

# ENGINE
func _ready():
	super()
	facing = facing
	start_idle.emit()


# PUBLIC
func move_stage(game_board_node: GameBoardNode):
	if dead:
		return
	grid_position = game_board_node.get_leap_position(self)
	start_move.emit()

func fall_stage(game_board_node: GameBoardNode):
	if dead:
		return
	grid_position = game_board_node.get_fall_position(self)
	start_fall.emit()

func place_stage(_game_board_node: GameBoardNode):
	if dead:
		return
	start_idle.emit()

func cleanup_stage(game_board_node: GameBoardNode):
	if dead:
		return
	if game_board_node.kills_frog(grid_position):
		kill()
	else:
		start_windup.emit()

func turn(increment: Util.RotateIncrement):
	var ret: int = facing + increment
	while ret < 0:
		ret += Util.Facing.size()
	facing = (ret % Util.Facing.size()) as Util.Facing

func kill():
	dead = true
	died.emit()
	death_timer.start()


# PRIVATE


# SIGNALS
func _on_frog_collider_collision_occurred() -> void:
	kill()

func _on_death_timer_timeout() -> void:
	queue_free()
