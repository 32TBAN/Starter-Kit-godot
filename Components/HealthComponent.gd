extends Component
class_name HealthComponent

signal health_changed(current: float, maximum: float)
signal damaged(amount: float)
signal healed(amount: float)
signal died

@export var max_health: float = 100.0
var current_health: float = 0.0

func initialize() -> void:
	current_health = max_health

func shutdown() -> void:
	pass
	
func damage(amount: float) -> void:
	if amount <= 0.0:
		return
	set_health(current_health - amount)
	damaged.emit(amount)

func heal(amount: float) -> void:
	if amount <= 0.0:
		return
	set_health(current_health + amount)
	healed.emit(amount)

func set_health(value: float) -> void:
	var old_health := current_health
	current_health = clamp(value, 0.0, max_health)
	if is_equal_approx(old_health, current_health):
		return
	health_changed.emit(current_health, max_health)
	if current_health <= 0.0:
		died.emit()

func kill() -> void:
	set_health(0.0)

func restore_full_health() -> void:
	set_health(max_health)

func is_dead() -> bool:
	return current_health <= 0.0

func get_health_percent() -> float:
	if max_health <= 0.0:
		return 0.0
	return current_health / max_health
