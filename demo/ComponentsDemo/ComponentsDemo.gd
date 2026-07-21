extends Node

@onready var movement: MovementComponent = $MovementComponent

func _ready() -> void:
	movement.movement_started.connect(_on_started)
	movement.movement_stopped.connect(_on_stopped)

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)
	movement.set_direction(direction)

func _on_started() -> void:
	print("Comenzó el movimiento")

func _on_stopped() -> void:
	print("Se detuvo")
