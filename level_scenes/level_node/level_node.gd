class_name LevelNode extends Node3D

signal stage_changed(new_stage: Stage)

enum Stage{ MOVE, FALL, PLACE, CLEANUP }

@onready var sfx: Array[AudioStreamPlayer] = [ %TickSfx0, %TickSfx1, %TickSfx2, %TickSfx3 ]
@onready var game_board_node: GameBoardNode = %GameBoardNode

var stage: Stage = Stage.CLEANUP:
	set(value):
		stage = value
		sfx[stage].play()
		stage_changed.emit(stage)
var nodes: Array[GridNode3D] = []


# ENGINE


# PUBLIC


# PRIVATE
func _pass_stage():
	stage = ((stage + 1) % Stage.size()) as Stage


# SIGNALS
func _on_stage_pass_timer_timeout() -> void:
	_pass_stage()
	match stage:
		Stage.MOVE:
			for node in nodes:
				node.move_stage(game_board_node)
		Stage.FALL:
			for node in nodes:
				node.fall_stage(game_board_node)
		Stage.PLACE:
			for node in nodes:
				node.place_stage(game_board_node)
		Stage.CLEANUP:
			for node in nodes:
				node.cleanup_stage(game_board_node)

func _on_child_entered_tree(node: Node) -> void:
	if node is GridNode3D:
		nodes.push_back(node)

func _on_child_exiting_tree(node: Node) -> void:
	if node is GridNode3D:
		nodes.erase(node)
