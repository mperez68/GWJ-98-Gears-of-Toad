@tool
class_name QuitButton extends SfxButton

enum Type{ BACK, QUIT_TO_MENU, QUIT_TO_DESKTOP }

@export var type: Type:
	set(value):
		type = value
		_update_text()
@export var save: bool = false:
	set(value):
		save = value
		_update_text()
@export var show_text: bool = true:
	set(value):
		show_text = value
		_update_text()


# ENGINE


# PUBLIC


# PRIVATE
func _update_text():
	super()
	if !show_text:
		text = ""
		return
	var all_text: String
	match type:
		Type.BACK:
			all_text = "Back"
		Type.QUIT_TO_MENU:
			all_text = "Quit"
		Type.QUIT_TO_DESKTOP:
			all_text = "Quit to Desktop"
	all_text = ("Save & " if save else "") + all_text
	text = all_text


# SIGNALS
func _on_pressed() -> void:
	super()
	if save:
		SaveStateManager.save_game_state()
	match type:
		Type.BACK:
			SceneManager.back()
		Type.QUIT_TO_MENU:
			SceneManager.quit_to_menu()
		Type.QUIT_TO_DESKTOP:
			SceneManager.quit()
