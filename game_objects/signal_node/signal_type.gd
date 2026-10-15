@abstract
@tool
class_name SignalType extends Resource

@export_placeholder("Name") var display_name: String = ""
@export var sprite: Texture2D:
	set(value):
		sprite = value
		changed.emit()

@abstract
func do(frog: FrogNode)
