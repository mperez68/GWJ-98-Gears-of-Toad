@tool
class_name FrogNode extends GridNode3D

signal color_changed(new_color: Color)

@onready var death_sfx: AudioStreamPlayer3D = %DeathSfx

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

func turn(increment: Util.RotateIncrement):
	var ret: int = facing + increment
	while ret < 0:
		ret += Util.Facing.size()
	facing = (ret % Util.Facing.size()) as Util.Facing

func kill():
	hide()
	death_sfx.play()


# PRIVATE


# SIGNALS
func _on_death_sfx_finished() -> void:
	queue_free()
