extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	var anim = get_node("KierownikAprobataMesh/AnimationPlayer")
	anim.play("Aprobata")
	pass # Replace with function body.
