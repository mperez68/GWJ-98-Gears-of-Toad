class_name GameEndControl extends Control

@onready var next_level_button: SceneChangeButton = %NextLevelButton


# ENGINE
func _ready() -> void:
	SignalBus.set_next_level.connect(_on_set_next_level)


# PUBLIC


# PRIVATE


# SIGNALS
func _on_set_next_level(new_scene: PackedScene):
	var link: SceneLink = preload("res://resources/ui/empty_next_level.tres").duplicate(true)
	link.packed_scene = new_scene
	next_level_button.scene_link = link
