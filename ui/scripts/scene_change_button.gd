@tool
class_name SceneChangeButton extends SfxButton

@export var scene_link: SceneLink:
	set(value):
		scene_link = value
		_update_text()
@warning_ignore("unused_private_class_variable")
@export_tool_button("Update Text", "RotateRight") var _update_button = _update_text
@export var to_back_stack: bool = false
@export var play_transition: bool = true


# ENGINE


# PUBLIC


# PRIVATE
func _update_text():
	if scene_link:
		text = scene_link.button_text
	else:
		text = ""
	super()


# SIGNALS
func _on_pressed() -> void:
	super()
	if scene_link:
		if scene_link.scene:
			SceneManager.new_scene(scene_link.scene, play_transition, to_back_stack)
		else:
			printerr("No scene set for %s(%s)" % [name, scene_link.button_text])
	else:
		printerr("No scene link set for %s" % [name])
