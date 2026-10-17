@tool
class_name LevelNode extends Node3D

const SPAWN: PackedScene = preload("res://game_objects/spawn_node/spawn_node.tscn")
const EXIT: PackedScene = preload("res://game_objects/exit_node/exit_node.tscn")
const SIG: PackedScene = preload("res://game_objects/signal_node/signal_node.tscn")
const OBS: PackedScene = preload("res://game_objects/obstacle_node/obstacle_node.tscn")

signal stage_changed(new_stage: Stage)

enum Stage{ MOVE, FALL, PLACE, CLEANUP }

@onready var sfx: Array[AudioStreamPlayer] = [ %TickSfx0, %TickSfx1, %TickSfx2, %TickSfx3 ]
@onready var game_board_node: GameBoardNode = %GameBoardNode
@onready var stage_pass_timer: Timer = %StagePassTimer

@export var passing_score: int = 8
@export var perfect_score: int = 12	#TODO holdout game end until this is hit or all frogs spawned
@export var next_level_scene: PackedScene
@export_category("Editor")
@export_tool_button("Spawn Pipe") var spawn = _generate_spawn
@export_tool_button("Exit Vent") var exit = _generate_exit
@export_tool_button("Signal") var sig = _generate_signal
@export_tool_button("Gear Obstacle") var gear = _generate_gear

var current_score: int = 0:
	set(value):
		current_score = value
		if current_score >= passing_score:
			SignalBus.level_success.emit()

var stage: Stage = Stage.CLEANUP:
	set(value):
		stage = value
		sfx[stage].play()
		stage_changed.emit(stage)
var nodes: Array[GridNode3D] = []


# ENGINE
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	MusicManager.play("Game")
	SignalBus.frog_scored.connect(_on_frog_scored)
	if next_level_scene:
		SignalBus.set_next_level.emit(next_level_scene)
	start_level()


# PUBLIC
func start_level():
	stage_pass_timer.start(Util.turn_speed)


# PRIVATE
func _pass_stage():
	stage = ((stage + 1) % Stage.size()) as Stage

func _generate_spawn():
	_gen_scene(SPAWN)

func _generate_exit():
	_gen_scene(EXIT)

func _generate_signal():
	_gen_scene(SIG)

func _generate_gear():
	_gen_scene(OBS)

func _gen_scene(scene: PackedScene):
	var new_scene := scene.instantiate()
	add_child(new_scene)
	new_scene.owner = self


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

func _on_frog_scored(_frog_type: FrogType):
	current_score += 1

func _on_child_entered_tree(node: Node) -> void:
	if Engine.is_editor_hint():
		return
	if node is GridNode3D:
		nodes.push_back(node)

func _on_child_exiting_tree(node: Node) -> void:
	if Engine.is_editor_hint():
		return
	if node is GridNode3D:
		nodes.erase(node)
