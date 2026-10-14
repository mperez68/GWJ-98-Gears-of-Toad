class_name Debug3dScene extends Node3D

@onready var frog_node: FrogNode = $FrogNode


# ENGINE
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		frog_node.leap($GameBoardNode)
	elif event.is_action_pressed("ui_left"):
		frog_node.turn(Util.RotateIncrement.LEFT)
	elif event.is_action_pressed("ui_right"):
		frog_node.turn(Util.RotateIncrement.RIGHT)
	elif event.is_action_pressed("ui_down"):
		frog_node.turn(Util.RotateIncrement.FLIP)


# PUBLIC


# PRIVATE


# SIGNALS
