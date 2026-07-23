extends Manager
class_name SceneManager
## --------------------------------------------------
## SceneManager
##
## Responsable de:
## - Cambiar escenas
## - Recargar escenas
## - Cerrar el juego
## --------------------------------------------------

func initialize() -> void:
	pass

func shutdown() -> void:
	pass

func update_current_scene() -> void:
	var scene := get_tree().current_scene
	if scene == null:
		return
	Gameload.register_level(scene)
	
func change_scene_packed(scene: PackedScene) -> void:
	if scene == null:
		push_error("SceneManager: Escena nula.")
		return
	get_tree().change_scene_to_packed(scene)
	EventBusLoad.scene_changed.emit(scene.resource_path)

func quit_game() -> void:
	get_tree().quit()
