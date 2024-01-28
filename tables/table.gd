extends Node3D

@export var ANIMATION_NAME: String = "Zgniatanie"
@export var aPlayer: AnimationPlayer = null

var type2animName = {0: "Promieniowanie",
					 1: "Walenie",
					 2: "Zgniatanie"}

var working_package = null

func _on_interaction_start(package, _interactee):
	if package != null:
		if type2animName[package.TYPE] != ANIMATION_NAME:
			return
		working_package = package
		aPlayer.play(ANIMATION_NAME)
		if has_node("DirectionalLight3D"):
			await get_tree().create_timer(1).timeout
			$DirectionalLight3D.visible = true
		return

func _on_interaction_stop(package, _interactee):
	if type2animName[package.TYPE] != ANIMATION_NAME:
		return
	if has_node("DirectionalLight3D"):
		$DirectionalLight3D.visible = false
	aPlayer.stop()

func _on_animation_finished(_anim_name):
	if type2animName[working_package.TYPE] != ANIMATION_NAME:
		return
	if ANIMATION_NAME == "Zgniatanie":
		working_package.PRESSED = true
	elif ANIMATION_NAME == "Promieniowanie":
		working_package.RADIATED = true
		if has_node("DirectionalLight3D"):
			var uranium = $DirectionalLight3D.duplicate()
			uranium.position = Vector3.ZERO
			working_package.add_child.call_deferred(uranium)
			$DirectionalLight3D.visible = false
		
	elif ANIMATION_NAME == "Walenie":
		working_package.HAMMERED = true
	working_package.POINT_VALUE += 10
	print(get_name(), ' skonczyla')
