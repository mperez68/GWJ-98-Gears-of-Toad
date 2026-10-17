extends Node

@warning_ignore("unused_signal")
signal frog_scored(frog_type: FrogType)
@warning_ignore("unused_signal")
signal change_hovered_signal(new_signal_type: SignalType)
@warning_ignore("unused_signal")
signal level_success(perfect_score_passed: bool)
@warning_ignore("unused_signal")
signal set_next_level(next_scene: PackedScene)
@warning_ignore("unused_signal")
signal set_invisible_tile(pos: Vector3i)
@warning_ignore("unused_signal")
signal end_level_button_pressed
@warning_ignore("unused_signal")
signal min_score_achieved
