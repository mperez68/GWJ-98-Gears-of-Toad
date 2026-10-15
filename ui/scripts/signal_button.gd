@tool
class_name SignalButton extends SfxButton

signal change_pending_signal_type(new_signal_type: SignalType)

@export var signal_type: SignalType:
	set(value):
		signal_type = value
		_update()


# ENGINE
func _ready() -> void:
	super()
	_update()


# PUBLIC


# PRIVATE
func _update():
	icon = signal_type.sprite if signal_type else null


# SIGNALS
func _pressed() -> void:
	change_pending_signal_type.emit(signal_type)
