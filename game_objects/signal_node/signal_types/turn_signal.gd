@tool
class_name TurnSignal extends SignalType

@export var rotate_increment: Util.RotateIncrement = Util.RotateIncrement.RIGHT

func do(frog: FrogNode):
	frog.turn(rotate_increment)
