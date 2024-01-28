extends Node3D


var transmission = preload("res://level/EndTransmission.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_interaction_start(package:RigidBody3D, interacee:Area3D):
	if package != null:
		var new_trans = transmission.instantiate()
		add_child.call_deferred(new_trans)
		interacee.unlinkPackage()
		package.reparent(new_trans.get_node("PathFollow3D"), false)
		get_parent().SCORE += 5
