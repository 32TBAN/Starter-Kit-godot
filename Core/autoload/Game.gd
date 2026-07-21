extends Node 
class_name Game  ##Representa el estado del juego  y ofrece funciones como pause
## change_escene, save_game etc..

enum State {
	BOOT,
	MENU,
	PLAYING,
	PAUSED,
	LOADING
}

signal state_changed(old_state: State, new_state: State)
signal player_registered(player: Node)
signal level_registered(level: Node)

var state : State = State.BOOT

var player : Node = null
var current_level : Node = null
var current_camera: Camera2D = null

##managers
var scene_manager: SceneManager
var pause_manager: PauseManager
var save_manager: SaveManager
var audio_manager: Node = null
var settings_manager: Node = null
var _managers: Array[Manager] = [] ##se utilizara mas adelante en versiones futuras.

func _ready() -> void:
	scene_manager = SceneManager.new()
	_register_manager(scene_manager)

	pause_manager = PauseManager.new()
	_register_manager(pause_manager)

	save_manager = SaveManager.new()
	_register_manager(save_manager)

func _register_manager(manager: Manager) -> void:
	_managers.append(manager)
	add_child(manager)
	manager.initialize()
	
func set_state(new_state: State) -> void:
	if state == new_state:
		return

	var old_state := state
	state = new_state
	state_changed.emit(old_state, new_state)
	
func register_player(player_node: Node) -> void:
	player = player_node
	player_registered.emit(player)
	EventBusLoad.player_spawned.emit(player)
	
func register_level(level_node: Node) -> void:
	current_level = level_node
	level_registered.emit(current_level)

func change_scene(scene_path: String) -> void:
	scene_manager.change_scene(scene_path)

func reload_scene() -> void:
	scene_manager.reload_scene()

func quit_game() -> void:
	scene_manager.quit_game()

func pause() -> void:
	pause_manager.pause()

func resume() -> void:
	pause_manager.resume()

func toggle_pause() -> void:
	pause_manager.toggle()

func is_paused() -> bool:
	return state == State.PAUSED

##SaveManager
func save_game(slot: String,data: Dictionary) -> bool:
	return save_manager.save(slot, data)

func load_game(slot: String) -> Dictionary:
	return save_manager.load(slot)

func has_save(slot:String) -> bool:
	return save_manager.has_save(slot)

func delete_save(slot:String) -> bool:
	return save_manager.delete_save(slot)
