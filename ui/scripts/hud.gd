class_name Hud extends Control

enum Page{ IN_GAME, OPTIONS }
@onready var page_map: Dictionary[Page, Control] = {
	Page.IN_GAME: %InGameControl,
	Page.OPTIONS: %OptionsControl
}


# ENGINE
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			SignalBus.change_hovered_signal.emit(null)



# PUBLIC


# PRIVATE


# SIGNALS
func _on_new_control_requested(new_page: Page) -> void:
	for key in page_map.keys():
		if key == new_page:
			page_map[key].show()
		else:
			page_map[key].hide()
