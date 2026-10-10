@tool
class_name TitleLabel extends Label

@export var min_width: float = 128:
	set(value):
		min_width = value
		custom_minimum_size = Vector2(value, value / 2)


# ENGINE
func _ready():
	text = ProjectSettings.get_setting("application/config/name")


# PUBLIC


# PRIVATE


# SIGNALS
