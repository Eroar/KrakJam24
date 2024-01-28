extends Node3D

@onready var aPlayer = $MlotekMesh/AnimationPlayer

func _on_interaction_start(_package, _interactee):
	aPlayer.play("Mlotek")

func _on_interaction_stop(_package, _interactee):
	aPlayer.stop()

func _on_animation_finished(_anim_name):
	print('Mlotek skonczyl')
