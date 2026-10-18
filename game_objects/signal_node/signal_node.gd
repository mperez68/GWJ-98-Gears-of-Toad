@tool
class_name SignalNode extends ColoredGridNode

const DISABLED_MATERIAL: Material = preload("res://resources/disabled_material.tres")

signal signal_type_changed(new_type: SignalType)

@onready var sprite_3d: Sprite3D = %Sprite3D
@onready var highlight: AreaLight3D = %Highlight
@onready var model: MeshInstance3D = %GRID_TILE_SIGNAL_NODE

@export var signal_type: SignalType:
	set(value):
		signal_type = value
		signal_type_changed.emit(signal_type)
@export var player_settable: bool = true:
	set(value):
		player_settable = value
		if model:
			model.set_surface_override_material(0, null if player_settable else DISABLED_MATERIAL)
			model.set_surface_override_material(1, null if player_settable else DISABLED_MATERIAL)
			model.set_surface_override_material(2, null if player_settable else DISABLED_MATERIAL)

var hovering: bool = false:
	set(value):
		if hovering == value:
			return
		hovering = value
		highlight.visible = hovering


# ENGINE
func _ready():
	super()
	if !Engine.is_editor_hint():
		SignalBus.change_hovered_signal.connect(_on_change_hovered_signal)
	_on_signal_type_changed(signal_type)
	player_settable = player_settable
	


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
	hovering = true and player_settable

func _on_mouse_area_mouse_exited() -> void:
	hovering = false

func _on_change_hovered_signal(new_signal_type: SignalType):
	if hovering:
		signal_type = new_signal_type
