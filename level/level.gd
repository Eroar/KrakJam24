extends Node3D

@export var package = preload("res://package/package.tscn")
var t = 0.0

func spawn_package():
	var new_package = package.instantiate()
	get_parent().get_node("Path3D/PathFollow3D").add_child.call_deferred(new_package)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_package()
	
func _process(delta):
	t += delta
	var path = get_parent().get_node("Path3D/PathFollow3D")
	var package = path.get_children()
	if path.progress_ratio >= .98:
		for i in package:
			i.queue_free()
		t = 0.0
		path.progress_ratio = 0.0
		# idk why but every other iteration package is node3d or package
		spawn_package()
		
	else:
		path.progress = 3.0 * t
