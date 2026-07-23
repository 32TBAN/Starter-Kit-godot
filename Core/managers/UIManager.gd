extends Manager
class_name UIManager

signal screen_registered(id: String)
signal screen_unregistered(id: String)

signal screen_opened(id: String)
signal screen_closed(id: String)

var _screens: Dictionary[String, Control] = {}

func initialize() -> void:
	for node in get_tree().get_nodes_in_group("ui_screen"):
		register_screen(node.screen_id, node)

func shutdown() -> void:
	_screens.clear()

func register_screen(id: String, screen: Control) -> void:
	if id.is_empty():
		push_error("UIManager: id vacío.")
		return
	if screen == null:
		push_error("UIManager: pantalla nula.")
		return
	if _screens.has(id):
		push_warning("UIManager: '%s' ya estaba registrado." % id)
	_screens[id] = screen

	screen_registered.emit(id)

func unregister_screen(id: String) -> void:
	if !_screens.has(id):
		return
	_screens.erase(id)
	screen_unregistered.emit(id)

func show(id: String) -> void:
	var screen := get_screen(id)
	if screen == null:
		return
	if screen.visible:
		return
	screen.visible = true
	screen_opened.emit(id)

func hide(id: String) -> void:
	var screen := get_screen(id)
	if screen == null:
		return
	if !screen.visible:
		return
	screen.visible = false
	screen_closed.emit(id)

func toggle(id: String) -> void:
	if is_open(id):
		hide(id)
	else:
		show(id)

func hide_all() -> void:
	for screen in _screens.values():
		screen.visible = false

func is_open(id: String) -> bool:
	var screen := get_screen(id)
	if screen == null:
		return false
	return screen.visible

func get_screen(id: String) -> Control:
	if !_screens.has(id):
		push_warning("UIManager: '%s' no registrado." % id)
		return null
	return _screens[id]

func show_exclusive(id: String) -> void:
	hide_all()
	show(id)
