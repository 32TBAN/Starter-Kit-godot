extends CharacterBody2D

@onready var movement: MovementComponent = $MovementComponent
@onready var health: HealthComponent = $HealthComponent
@onready var camera: CameraComponent = $CameraComponent

func _ready() -> void:
	movement.movement_started.connect(_on_started)
	movement.movement_stopped.connect(_on_stopped)
	health.health_changed.connect(
	func(current, maximum):
		print(current, "/", maximum)
	)

	health.died.connect(
		func():
			print("Jugador muerto")
	)
	camera.initialize()

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)
	movement.set_direction(direction)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		movement.add_velocity(Vector2.RIGHT * 300)

	if event.is_action_pressed("ui_cancel"):
		health.damage(20)

	if event.is_action_pressed("ui_focus_next"):
		health.heal(10)

func _on_started() -> void:
	print("Comenzó el movimiento")

func _on_stopped() -> void:
	print("Se detuvo")
