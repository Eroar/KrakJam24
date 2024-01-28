extends Node3D

@export var ANIMATION_NAME: String = "Zgniatanie"
@export var aPlayer: AnimationPlayer = null

var working_package = null

func _on_interaction_start(package, _interactee):
	if package != null:
		working_package = package
		aPlayer.play(ANIMATION_NAME)
		return

func _on_interaction_stop(_package, _interactee):
	aPlayer.stop()

func _on_animation_finished(_anim_name):
	if ANIMATION_NAME == "Zgniatanie":
		working_package.PRESSED = true
	elif ANIMATION_NAME == "Promieniowanie":
		working_package.RADIATED = true
	elif  ANIMATION_NAME == "Walenie":
		working_package.HAMMERED = true
	working_package.POINT_VALUE += 10
	print(get_name(), ' skonczyla')
