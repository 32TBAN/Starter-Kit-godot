extends Manager
class_name PauseManager

func initialize() -> void:
	pass

func shutdown() -> void:
	pass

func pause() -> void:
	if get_tree().paused:
		return
	get_tree().paused = true

	Gameload.set_state(Game.State.PAUSED)
	EventBusLoad.game_paused.emit()

func resume() -> void:
	if !get_tree().paused:
		return
	get_tree().paused = false
	Gameload.set_state(Game.State.PLAYING)
	EventBusLoad.game_resumed.emit()

func toggle() -> void:
	if get_tree().paused:
		resume()
	else:
		pause()
