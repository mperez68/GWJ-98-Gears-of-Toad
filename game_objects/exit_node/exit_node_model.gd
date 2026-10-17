@tool
class_name ExitNodeModel extends ColorMesh

@onready var animation_player: AnimationPlayer = $AnimationPlayer


# ENGINE


# PUBLIC


# PRIVATE


# SIGNALS
func _on_chute_opened():
	animation_player.play("Take 001", -1, 3.0)

func _on_chute_closed():
	animation_player.play("Take 001", -1, -3.0, true)
