extends Node3D

@export var ANIMATION_NAME: String = "Zgniatanie"
@export var aPlayer: AnimationPlayer = null

func _on_interaction_start(package, _interactee):
    if package == null:
        return
	aPlayer.play(ANIMATION_NAME)

func _on_interaction_stop(_package, _interactee):
	aPlayer.stop()

func _on_animation_finished(_anim_name):
	
	print(get_name(), ' skonczyla')
