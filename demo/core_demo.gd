extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Gameload.state_changed.connect(_on_state_changed)
	Gameload.set_state(Game.State.PLAYING)
	
	Gameload.player_registered.connect(_on_player_registered)
	var fake_player := Node.new()
	Gameload.register_player(fake_player)
	
	Gameload.level_registered.connect(_on_level_registered)
	var fake_level := Node.new()
	Gameload.register_level(fake_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func test(message: String) -> void:
	print("[TEST] ", message)
	
func _on_state_changed(old_state, new_state):
	test("Cambio de estado: %s -> %s" % [old_state, new_state])

func _on_player_registered(player):
	print(player)

func _on_pause():
	test("Pause OK")
	
func _on_level_registered(node):
	test("nivel registrado")
	
