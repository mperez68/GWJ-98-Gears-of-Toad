class_name Hud extends Control

const SIGNAL_BUTTON: PackedScene = preload("res://ui/signal_button.tscn")

enum Page{ IN_GAME, OPTIONS }
@onready var page_map: Dictionary[Page, Control] = {
	Page.IN_GAME: %InGameControl,
	Page.OPTIONS: %OptionsControl
}
@onready var signal_setter_container: HBoxContainer = %SignalSetterContainer

@export var signal_options: Array[SignalType] = [
	null,
	preload("res://game_objects/signal_node/presets/left_turn.tres"),
	preload("res://game_objects/signal_node/presets/right_turn.tres"),
	preload("res://game_objects/signal_node/presets/flip_around.tres")
]

var queued_signal_type: SignalType = null


# ENGINE
func _ready() -> void:
	for option in signal_options:
		var btn: SignalButton = SIGNAL_BUTTON.instantiate()
		btn.signal_type = option
		btn.change_pending_signal_type.connect(_on_change_pending_signal_type)
		signal_setter_container.add_child(btn)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			SignalBus.change_hovered_signal.emit(queued_signal_type)


# PUBLIC


# PRIVATE


# SIGNALS
func _on_new_control_requested(new_page: Page) -> void:
	for key in page_map.keys():
		if key == new_page:
			page_map[key].show()
		else:
			page_map[key].hide()

func _on_change_pending_signal_type(new_signal_type: SignalType):
	queued_signal_type = new_signal_type
