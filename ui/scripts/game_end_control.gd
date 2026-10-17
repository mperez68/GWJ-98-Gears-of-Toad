class_name GameEndControl extends Control

@onready var next_level_button: SceneChangeButton = %NextLevelButton
@onready var passed_rect: TextureRect = %PassedRect
@onready var hard_mode_rect: TextureRect = %HardModeRect

@export var rect_default: Color = Color.WHITE
@export var rect_disabled: Color = Color.WHITE


# ENGINE
func _ready() -> void:
	SignalBus.set_next_level.connect(_on_set_next_level)
	SignalBus.level_success.connect(_on_level_success)


# PUBLIC


# PRIVATE


# SIGNALS
func _on_set_next_level(new_scene: PackedScene):
	var link: SceneLink = preload("res://resources/ui/empty_next_level.tres").duplicate(true)
	link.packed_scene = new_scene
	next_level_button.scene_link = link

func _on_level_success(perfect_score_passed: bool):
	hard_mode_rect.self_modulate = rect_default if perfect_score_passed else rect_disabled
