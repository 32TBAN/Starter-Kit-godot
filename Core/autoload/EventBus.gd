extends Node
class_name EventBus
## sirve para comunicar sistemas que no deberían conocerse entre sí. no debe tener
## varialbes ni logica
# Game
signal game_started
signal game_paused
signal game_resumed
signal game_over

# Scene
signal scene_changed(scene_path: String)

# Player
signal player_spawned(player: Node)
signal player_died(player: Node)

# Save
signal game_saved
signal game_loaded
