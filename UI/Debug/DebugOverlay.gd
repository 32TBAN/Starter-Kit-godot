extends Control
class_name DebugOverlay

@export var refresh_rate := 0.25
@onready var label: RichTextLabel = $MarginContainer/PanelContainer/RichTextLabel
var _timer := 0.0

func _ready():
	Gameload.debug_manager.value_changed.connect(_refresh)
	Gameload.debug_manager.value_removed.connect(_refresh)
	Gameload.debug_manager.values_cleared.connect(_refresh)
	_refresh()

func _process(delta):
	_timer += delta
	if _timer >= refresh_rate:
		_timer = 0
		_refresh()

func _refresh():
	var text := ""
	text += "[b]FRAMEWORK[/b]\n\n"
	text += "FPS: %d\n" % Engine.get_frames_per_second()
	text += "State: %s\n" % Gameload.get_state_name()
	text += "Paused: %s\n" % get_tree().paused

	if Gameload.current_level:
		text += "Scene: %s\n" % Gameload.current_level.name

	if Gameload.player:
		text += "\n[b]PLAYER[/b]\n\n"
		text += "Position: %s\n" % Gameload.player.global_position
	var values := Gameload.debug_manager.get_values()

	if !values.is_empty():
		text += "\n[b]CUSTOM[/b]\n\n"
		for key in values:
			text += "%s: %s\n" % [key, values[key]]
	label.text = text
