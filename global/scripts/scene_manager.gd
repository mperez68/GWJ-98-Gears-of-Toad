extends Node

const TRANSITION: PackedScene = preload("res://ui/transition.tscn")

var back_stack: Array[PackedScene]
var queued_scene: PackedScene
var transitioning: bool = true

@export var menu_path: String = "res://main_scenes/menus/main_menu.tscn"


# ENGINE
func _ready() -> void:
	if load(menu_path) == null and !Engine.is_editor_hint():
		printerr("Menu Path in SceneManager not valid!")


# PUBLIC
func new_scene(scene: PackedScene, transition: bool = true, add_to_backstack: bool = false):
	if add_to_backstack:
		var packed: PackedScene = PackedScene.new()
		packed.pack(get_tree().current_scene)
		back_stack.push_back(packed)
	if transition:
		queued_scene = scene
		var new_transition: Transition = TRANSITION.instantiate()
		new_transition.fade = "out"
		new_transition.transition_finished.connect(_on_transition_finished)
		get_tree().current_scene.add_child(new_transition)
	else:
		get_tree().change_scene_to_packed(scene)

func back(transition: bool = true):
	if back_stack.is_empty():
		printerr("Back stack is empty!")
		quit_to_menu(transition)
	else:
		new_scene(back_stack.pop_back())

func quit_to_menu(transition: bool = true):
	new_scene(load(menu_path), transition)

func quit(transition: bool = true):
	if transition:
		var new_transition: Transition = TRANSITION.instantiate()
		new_transition.fade = "out"
		new_transition.transition_finished.connect(_on_transition_finished)
		get_tree().current_scene.add_child(new_transition)
	else:
		get_tree().quit()


# PRIVATE


# SIGNALS
func _on_transition_finished(fade: String):
	if queued_scene and fade == "out":
		transitioning = true
		get_tree().change_scene_to_packed(queued_scene)
		queued_scene = null
	else:
		get_tree().quit()
		
