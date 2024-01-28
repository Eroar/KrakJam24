extends Node3D


enum PCKG_TYPE {YELLOW, RED, BLUE}

@export var TYPE = PCKG_TYPE.YELLOW

var transmission = preload("res://level/EndTransmission.tscn")

func _on_interaction_start(package:RigidBody3D, interacee:Area3D):
	if package != null:
		if TYPE == package.TYPE:
			var new_trans = transmission.instantiate()
			add_child.call_deferred(new_trans)
			interacee.unlinkPackage()
			package.reparent(new_trans.get_node("PathFollow3D"), false)
			get_parent().SCORE += 5
