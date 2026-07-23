extends UIScreen
class_name MainMenu

@export var first_level: PackedScene

func _on_play_pressed() -> void:
	if first_level == null:
		push_warning("No hay nivel inicial asignado.")
		return
		
	Gameload.change_scene_packed(first_level)
	
func _on_settings_pressed():
	Gameload.show_screen("settings")

func _on_credits_pressed():
	push_warning("Credits no implementado.")

func _on_exit_pressed():
	Gameload.quit_game()
