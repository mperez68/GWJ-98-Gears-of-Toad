class_name FrogCollider extends Area3D

signal collision_occurred


# ENGINE


# PUBLIC
func frog_collided():
	collision_occurred.emit()


# PRIVATE


# SIGNALS
func _on_area_entered(area: Area3D) -> void:
	if area is FrogCollider:
		area.frog_collided()
		frog_collided()
