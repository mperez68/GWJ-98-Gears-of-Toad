@tool
class_name FrogSetup extends ColorMesh

@onready var animation_player: AnimationPlayer = %AnimationPlayer


# ENGINE


# PUBLIC


# PRIVATE


# SIGNALS
func _on_frog_node_start_idle() -> void:
	pass
	#animation_player.play_section("Take 001", 0.4, -1, -1, 3.0)

func _on_frog_node_start_move() -> void:
	animation_player.play_section("Take 001", 0.15)

func _on_frog_node_start_fall() -> void:
	animation_player.play_section("Take 001", 0.4, -1, -1, 3.0)
	#animation_player.play_section("Take 001", 0.3, 0.4)
