extends Node3D

@onready var game = $'/root/Game'
@onready var interacteeZone = $'/root/Game/Player/InteracteeZone'

func on_interaction(_interactable):
	game.removeScore(0.1)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("KierownikDysaprobataMesh ready with player: ", interacteeZone.get_name())
	# connec to signal interacting from InteracteeZone
	interacteeZone.connect("interacting", on_interaction)
	var anim = $"KierownikDysaprobataMesh/AnimationPlayer"
	anim.get_animation("Dysaprobata").loop = true
	anim.play("Dysaprobata")
	# remove this node after 3 seconds
	await get_tree().create_timer(3.0).timeout
	queue_free()

