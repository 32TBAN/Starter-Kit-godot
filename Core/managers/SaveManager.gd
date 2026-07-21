extends Manager
class_name SaveManager

const SAVE_FOLDER := "user://saves/"
const SAVE_PATH := SAVE_FOLDER + "%s.json"

func initialize() -> void:
	DirAccess.make_dir_recursive_absolute(SAVE_FOLDER)
	
func shutdown() -> void:
	pass

func save(slot: String, data: Dictionary) -> bool:
	var file := FileAccess.open(SAVE_PATH % slot, FileAccess.WRITE)
	if file == null:
		push_error("SaveManager: No se pudo abrir el archivo para guardar.")
		return false
	var json := JSON.stringify(data, "\t")
	file.store_string(json)
	file.close()
	EventBusLoad.game_saved.emit()
	return true


func load(slot: String) -> Dictionary:
	if !FileAccess.file_exists(SAVE_PATH % slot):
		return {}
	var file := FileAccess.open(SAVE_PATH % slot, FileAccess.READ)
	if file == null:
		push_error("SaveManager: No se pudo abrir el archivo.")
		return {}
	var content := file.get_as_text()
	file.close()
	var json := JSON.new()
	var error := json.parse(content)
	if error != OK:
		push_error("SaveManager: JSON inválido.")
		return {}
	EventBusLoad.game_loaded.emit()
	return json.data

func has_save(slot: String) -> bool:
	return FileAccess.file_exists(SAVE_PATH % slot)
	
func delete_save(slot: String) -> bool:
	if !has_save(slot):
		return false
	return DirAccess.remove_absolute(SAVE_PATH % slot) == OK
