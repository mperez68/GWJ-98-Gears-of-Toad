@tool
class_name FrogNode extends ColoredGridNode

signal start_windup
signal start_move
signal start_fall
signal start_idle
signal died
signal sfx_active_changed(new_value: bool)

@onready var death_timer: Timer = %DeathTimer

@export var leap_distance: int = 1
@export var sfx_active: bool = true:
	set(value):
		sfx_active = value
		if !Engine.is_editor_hint():
			sfx_active_changed.emit(sfx_active)

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
