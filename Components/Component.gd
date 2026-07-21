extends Node
class_name Component
#Un componente añade una única capacidad a un nodo.
var entity: Node:
	get:
		return get_parent()

func _ready():
	initialize()

func _exit_tree():
	shutdown()

func initialize() -> void:
	pass

func shutdown() -> void:
	pass
