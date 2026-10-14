@tool
class_name FrogType extends Resource

enum FrogColor{ NONE, RED, BLUE, GREEN }
const COLOR_MAP: Dictionary[FrogColor, Color] = {
	FrogColor.NONE: Color.ANTIQUE_WHITE,
	FrogColor.RED: Color.INDIAN_RED,
	FrogColor.BLUE: Color.DARK_BLUE,
	FrogColor.GREEN: Color.SEA_GREEN
}

@export_placeholder("Name") var display_name: String = ""
@export var _color: FrogColor = FrogColor.NONE:
	set(value):
		_color = value
		changed.emit()

func get_color() -> Color:
	return COLOR_MAP[_color]
