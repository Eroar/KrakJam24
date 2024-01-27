extends Node3D


var has_package: bool = false
var package = preload("res://package/package.blend")

func spawn_node():
	var new_package = package.instantiate()
	new_package.position = Vector3(0, 0, 20)
	add_child(new_package)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_node()

