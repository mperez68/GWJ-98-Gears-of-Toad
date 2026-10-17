@tool
class_name FrogSetup extends ColorMesh

@onready var animation_player: AnimationPlayer = %AnimationPlayer


# ENGINE


# PUBLIC


# PRIVATE


# SIGNALS
func _on_frog_node_start_idle() -> void:
	animation_player.stop()	# TODO idle animation

func _on_frog_node_start_move() -> void:
	animation_player.play("Take 001")

func _on_frog_node_start_fall() -> void:
	animation_player.stop()	# TODO idle animation
