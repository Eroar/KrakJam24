extends Node3D

@export var path = preload("res://package/PackagePath.tscn")
var t = 0.0

func spawn_package():
	var new_path = path.instantiate()
	get_parent().add_child.call_deferred(new_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_package()
	
func _process(delta):
	if Input.is_action_just_pressed("spawn_box"):
		spawn_package()
