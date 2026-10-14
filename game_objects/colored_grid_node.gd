@tool
@abstract
class_name ColoredGridNode extends GridNode3D

signal color_changed(new_color: Color)

@export var color: Color = Color.FIREBRICK:
	set(value):
		color = value
		color_changed.emit(color)
@export var frog_type: FrogType:
	set(value):
		if frog_type:
			frog_type.changed.disconnect(_on_frog_type_changed)
		frog_type = value
		if frog_type:
			frog_type.changed.connect(_on_frog_type_changed)
		_on_frog_type_changed()


# ENGINE
func _ready():
	super()
	_on_frog_type_changed()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if !frog_type:
		warnings.push_back("No FrogType set!")
	return warnings


# PUBLIC
func is_frog_compatible(node: Node) -> bool:
	if node is not ColoredGridNode:
		return false
	if frog_type._color == FrogType.FrogColor.NONE or frog_type._color == node.frog_type._color:
		return true
	return false


# PRIVATE


# SIGNALS
func _on_frog_type_changed():
	color = frog_type.get_color() if frog_type else Color.WHITE
