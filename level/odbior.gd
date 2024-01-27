extends Node3D


var has_package: bool = false
@export var package = preload("res://package/package.tscn")

func spawn_node():
	var new_package = package.instantiate()
	new_package.position = $".".position + Vector3(0 ,0, 0)
	get_parent().add_child.call_deferred(new_package)
	has_package = true

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_node()
