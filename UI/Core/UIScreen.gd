extends Control
class_name UIScreen

@export var screen_id: String
@export var start_visible := false

func _ready() -> void:
	visible = start_visible
	if screen_id.is_empty():
		push_error("%s no tiene screen_id." % name)
		return
	if Gameload.ui_manager == null:
		push_error("UIManager no inicializado.")
		return
	Gameload.ui_manager.register_screen(screen_id, self)

func _exit_tree() -> void:
	if Gameload.ui_manager:
		Gameload.ui_manager.unregister_screen(screen_id)
