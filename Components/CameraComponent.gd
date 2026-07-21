extends Component
class_name CameraComponent
@export var enabled := true
@export var smoothing_enabled := true
@export var smoothing_speed := 6.0

@export var camera_path: NodePath = "Camera2D"
var _camera: Camera2D

func initialize() -> void:
	_camera = get_node_or_null(camera_path) as Camera2D
	if _camera == null:
		push_error("%s no encontró una Camera2D hija." % name)
		return
	_camera.enabled = enabled
	_camera.position_smoothing_enabled = smoothing_enabled
	_camera.position_smoothing_speed = smoothing_speed

func enable() -> void:
	enabled = true
	if _camera:
		_camera.enabled = true

func disable() -> void:
	enabled = false
	if _camera:
		_camera.enabled = false

func set_zoom(value: Vector2) -> void:
	if _camera:
		_camera.zoom = value

func get_camera() -> Camera2D:
	return _camera
