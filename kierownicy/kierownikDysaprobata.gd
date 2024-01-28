extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	var anim = get_node("KierownikDysaprobataMesh/AnimationPlayer")
	anim.get_animation("Dysaprobata").loop = true
	anim.play("Dysaprobata")
