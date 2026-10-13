@tool
class_name FrogNode extends GridNode3D

signal color_changed(new_color: Color)

@export var color: Color = Color.FIREBRICK:
	set(value):
		color = value
		color_changed.emit(color)
@export var facing: Util.Facing:
	set(value):
		facing = value
		if is_node_ready():
			look_at(position + Vector3(Util.get_facing_vector(facing)))


# ENGINE
func _ready():
	look_at(position + Vector3(Util.get_facing_vector(facing)))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		leap()
	elif event.is_action_pressed("ui_cancel"):
		facing = ((facing + 1) % Util.Facing.size()) as Util.Facing


# PUBLIC
func leap(distance: int = 1):
	grid_position += Util.get_facing_vector(facing) * distance


# PRIVATE


# SIGNALS
