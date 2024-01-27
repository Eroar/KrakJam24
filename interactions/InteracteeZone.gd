extends Area3D

func tryToInteract():
	var collisions = get_overlapping_areas()
	collisions = collisions.filter(func(x): return x.is_in_group("interactable"))

	# no interactable object in range
	if collisions.size() == 0:
		print("no interactable object in range")
		return
	
	var interactableObject = collisions[0].get_parent()
	interactableObject.emit_signal("interaction_requested")


func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		tryToInteract()

