extends Node3D

@export var ANIMATION_NAME: String = "Zgniatanie"
@export var aPlayer: AnimationPlayer = null

func _on_interaction_start(package, _interactee):
	print(package)
	if package != null:
		aPlayer.play(ANIMATION_NAME)
		if ANIMATION_NAME == "Zgniatanie":
			package.PRESSED = true
		elif ANIMATION_NAME == "Promieniowanie":
			package.RADIATED = true
		elif  ANIMATION_NAME == "Walenie":
			package.HAMMERED = true
			
		package.POINT_VALUE += 10
		return

func _on_interaction_stop(_package, _interactee):
	aPlayer.stop()

func _on_animation_finished(_anim_name):
	
	print(get_name(), ' skonczyla')
