extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	var anim = get_node("KierownikAprobataMesh/AnimationPlayer")
	anim.get_animation("Aprobata").loop = true
	anim.play("Aprobata")
