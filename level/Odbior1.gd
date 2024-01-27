extends Node3D


var transmission = preload("res://level/EndTransmission.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on__interaction_start(package:RigidBody3D):
	if package != null:
		var new_trans = transmission.instantiate()
		add_child.call_deferred(new_trans)
		package.reparent(new_trans.get_node("PathFollow3D"), false)
		