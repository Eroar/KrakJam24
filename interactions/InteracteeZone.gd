extends Area3D

var canInteract = false
var interactableObject = null

func _on_area_entered(area:Area3D):
	if area.is_in_group("interactable"):
		canInteract = true
		interactableObject = area

func _on_area_exited(area:Area3D):
	if area.is_in_group("interactable"):
		canInteract = false
		interactableObject = null


func _process(_delta):
	if !canInteract:
		return
	if interactableObject == null:
		return

	if Input.is_action_just_pressed("interact"):
		interactableObject.emit_signal("interaction_requested")
