extends Manager
class_name SceneManager
##cambia de escena, recarga la escena, sale del jeugo, registra el nivel en GAme,
##notifica cmabios mediante eventBUs

func initialize() -> void:
	pass

func shutdown() -> void:
	pass

func update_current_scene() -> void:
	var scene := get_tree().current_scene
	if scene == null:
		return
	Gameload.register_level(scene)
	
func change_scene(scene_path: String) -> void:
	if scene_path.is_empty():
		push_error("SceneManager: La ruta de la escena está vacía.")
		return
	var error := get_tree().change_scene_to_file(scene_path)
	if error != OK:
		push_error("SceneManager: No se pudo cargar la escena: %s" % scene_path)
		return
	EventBusLoad.scene_changed.emit(scene_path)

func reload_scene() -> void:
	var current_scene := get_tree().current_scene
	if current_scene == null:
		push_error("SceneManager: No existe una escena cargada.")
		return
	change_scene(current_scene.scene_file_path)

func quit_game() -> void:
	get_tree().quit()
