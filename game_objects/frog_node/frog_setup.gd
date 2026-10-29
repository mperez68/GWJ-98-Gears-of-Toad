@tool
class_name FrogSetup extends ColorMesh

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var death_sfx: AudioStreamPlayer3D = %DeathSfx
@onready var jump_sfx: AudioStreamPlayer3D = %JumpSfx

var sfx_active: bool = true


# ENGINE


# PUBLIC


# PRIVATE


# SIGNALS
func _on_frog_node_start_idle() -> void:
	_on_animation_player_animation_finished("IDLE_A")

func _on_frog_node_start_move() -> void:
	if sfx_active:
		jump_sfx.play()
	animation_player.play("Leap")

func _on_frog_node_start_fall() -> void:
	animation_player.play("Landing")

func _on_frog_node_died() -> void:
	if sfx_active:
		death_sfx.play()
	animation_player.stop()
	animation_player.play_section("DEATH", 0.15)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name.contains("IDLE"):
		var idles: Array[String] = ["IDLE_A", "IDLE_B", "IDLE_C"]
		idles.erase(anim_name)
		animation_player.play(idles.pick_random())

func _on_frog_node_start_windup() -> void:
	animation_player.play("Windup")

func _on_frog_node_sfx_active_changed(new_value: bool) -> void:
	sfx_active = new_value
