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
	super()
	facing = facing

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"):
		#leap()
	#elif event.is_action_pressed("ui_left"):
		#turn(Util.RotateIncrement.LEFT)
	#elif event.is_action_pressed("ui_right"):
		#turn(Util.RotateIncrement.RIGHT)
	#elif event.is_action_pressed("ui_down"):
		#turn(Util.RotateIncrement.FLIP)


# PUBLIC
func leap(distance: int = 1):
	grid_position += Util.get_facing_vector(facing) * distance

func turn(increment: Util.RotateIncrement):
	var ret: int = facing + increment
	while ret < 0:
		ret += Util.Facing.size()
	facing = (ret % Util.Facing.size()) as Util.Facing
	


# PRIVATE


# SIGNALS
