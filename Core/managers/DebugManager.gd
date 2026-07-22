extends Manager
class_name DebugManager

signal value_changed(key: String, value)
signal value_removed(key: String)
signal values_cleared()

var _values: Dictionary = {}

func initialize() -> void:
	pass

func shutdown() -> void:
	clear()

func set_value(key: String, value) -> void:
	if key.is_empty():
		push_warning("DebugManager: key vacía.")
		return
	_values[key] = value
	value_changed.emit(key, value)

func get_value(key: String, default_value = null):
	return _values.get(key, default_value)

func has_value(key: String) -> bool:
	return _values.has(key)

func remove_value(key: String) -> void:
	if !_values.has(key):
		return
	_values.erase(key)
	value_removed.emit(key)

func clear() -> void:
	if _values.is_empty():
		return
	_values.clear()
	values_cleared.emit()

func get_values() -> Dictionary:
	return _values.duplicate()
