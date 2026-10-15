@tool
class_name SignalNode extends ColoredGridNode

signal signal_type_changed(new_type: SignalType)

@onready var sprite_3d: Sprite3D = %Sprite3D

@export var signal_type: SignalType:
	set(value):
		signal_type = value
		signal_type_changed.emit(signal_type)

var hovering: bool = false


# ENGINE
func _ready():
	super()
	if !Engine.is_editor_hint():
		SignalBus.change_hovered_signal.connect(_on_change_hovered_signal)
	_on_signal_type_changed(signal_type)
	


# PUBLIC
func place_stage(_game_board_node: GameBoardNode):
	for node in get_tree().get_nodes_in_group(Util.FROG_NODE_KEY):
		if grid_position == node.grid_position and is_frog_compatible(node):
			if signal_type:
				signal_type.do(node)


# PRIVATE


# SIGNALS
func _on_signal_type_changed(new_type: SignalType) -> void:
	scale = Vector3.ONE if new_type else Vector3(0.5, 0.5, 0.5)
	if sprite_3d:
		sprite_3d.texture = new_type.sprite if new_type else null

func _on_mouse_area_mouse_entered() -> void:
	hovering = true

func _on_mouse_area_mouse_exited() -> void:
	hovering = false

func _on_change_hovered_signal(new_signal_type: SignalType):
	if hovering:
		signal_type = new_signal_type
