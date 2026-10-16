@tool
class_name SpawnNode extends ColoredGridNode

const FROG: PackedScene = preload("res://game_objects/frog_node/frog_node.tscn")

## Number of frogs that will be emitted. -1 is infinite.
@export var charges: int = -1
## Number of reset turns required for a frog to spawn
@export var recharge: int = 0
## Turns waited before launching first frog
@export var delay: int = 0

@onready var recharge_count: int = recharge
@onready var highlight: AreaLight3D = %Highlight


# ENGINE
func _ready():
	super()
	if !Engine.is_editor_hint():
		SignalBus.set_invisible_tile.emit(grid_position + Vector3i.DOWN)


# PUBLIC
func move_stage(_game_board_node: GameBoardNode):
	highlight.visible = delay == 0 and charges != 0

func place_stage(_game_board_node: GameBoardNode):
	if delay > 0:
		delay -= 1
		return
	if charges == 0:
		return
	if recharge_count < recharge:
		recharge_count += 1
		return
	recharge_count = 0
	var new_frog: FrogNode = FROG.instantiate()
	new_frog.grid_position = grid_position
	new_frog.facing = facing
	new_frog.frog_type = frog_type
	add_sibling(new_frog)
	charges -= 1


# PRIVATE


# SIGNALS
