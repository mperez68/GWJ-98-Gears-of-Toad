class_name CameraHolderNode extends Node3D

var movement_vector: Vector2 = Vector2.ZERO
var turn_angle: float = 0.0
@export var pan_speed: float = 20
@export var rotate_speed: float = 5
@export var auto_rotate: bool = false



# ENGINE
func _ready() -> void:
	if auto_rotate:
		turn_angle = rotate_speed

func _physics_process(delta: float) -> void:
	position += (global_transform.basis * Vector3(movement_vector.x, 0, movement_vector.y)) * delta * pan_speed
	rotate(Vector3.UP, turn_angle * delta * rotate_speed)

func _unhandled_input(_event: InputEvent) -> void:
	if auto_rotate:
		return
	movement_vector = Input.get_vector("scroll_left", "scroll_right", "scroll_up", "scroll_down").normalized()
	turn_angle = Input.get_axis("rotate_clockwise", "rotate_counter_clockwise")


# PUBLIC


# PRIVATE


# SIGNALS
