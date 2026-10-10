@tool
class_name SfxButton extends Button

@export var icon_side: HorizontalAlignment:
	set(value):
		icon_side = value
		_update_text()


# ENGINE
func _ready() -> void:
	_update_text()

func _enter_tree() -> void:
	pressed.connect(_on_pressed)

func _exit_tree() -> void:
	pressed.disconnect(_on_pressed)


# PUBLIC


# PRIVATE
func _update_text():
	icon_alignment = icon_side if text != "" else HORIZONTAL_ALIGNMENT_CENTER


# SIGNALS
func _on_pressed() -> void:
	SfxManager.play(SfxManager.Sfx.CLICK)
