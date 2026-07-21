extends Component
class_name MovementComponent

signal movement_started
signal movement_stopped

@export var max_speed: float = 200.0
@export var acceleration: float = 1200.0
@export var deceleration: float = 1500.0

var velocity: Vector2 = Vector2.ZERO

var _direction: Vector2 = Vector2.ZERO
var _body: CharacterBody2D
var _moving := false

func initialize() -> void:
	_body = entity as CharacterBody2D
	if _body == null:
		push_error("%s debe ser hijo de CharacterBody2D." % name)
		set_physics_process(false)
		return
	set_physics_process(true)
	
func set_direction(direction: Vector2) -> void:
	_direction = direction.normalized()

func stop() -> void:
	_direction = Vector2.ZERO

func set_speed(speed: float) -> void:
	max_speed = max(speed, 0.0)

func get_velocity() -> Vector2:
	return velocity
	
func is_moving() -> bool:
	return _moving
	
func _physics_process(delta: float) -> void:
	var target_velocity := _direction * max_speed
	if _direction != Vector2.ZERO:
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)

	_body.velocity = velocity
	_body.move_and_slide()

	var moving := velocity.length() > 0.01

	if moving != _moving:
		_moving = moving
		if _moving:
			movement_started.emit()
		else:
			movement_stopped.emit()

func add_velocity(force: Vector2) -> void:
	velocity += force
