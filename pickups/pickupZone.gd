extends Area3D

# parent of pickupableZone objects
var pickedObject = null
# the collision shape of the pickedObject
var collisionShape = null

# internal flags
var pickingUp = false
var pickedUp = false

func tryToInteract():
	var collisions = get_overlapping_areas()
	collisions = collisions.filter(func(x): return x.is_in_group("interactable"))

	# no interactable object in range
	if collisions.size() == 0:
		print("no interactable object in range")
		return
	
	var interactableObject = collisions[0]
	interactableObject.emit_signal("interaction_requested", null)


func findRigidBody3D(parentNode:Node) -> RigidBody3D:
	if parentNode is RigidBody3D:
		return parentNode
	for node in parentNode.get_children():
		var foundNode = findRigidBody3D(node)
		if foundNode != null:
			return foundNode
		
		if node is RigidBody3D:
			return node
	return null

func pickUp():
	if pickedUp || pickingUp:
		return
	pickingUp = true

	var collisions = get_overlapping_areas()
	collisions = collisions.filter(func(x): return x.is_in_group("pickupable"))

	# no pickupable object in range
	if collisions.size() == 0:
		pickingUp = false
		print("no pickupable object in range")
		return
	
	pickedObject = collisions[0].get_parent()
	print("picking up", pickedObject)

	collisionShape = findRigidBody3D(pickedObject)
	if collisionShape == null:
		push_error("no collision shape found")
		return

	pickedObject.reparent(self)

	# disable collision and physics on picked up object
	collisionShape.set_collision_layer(0)
	collisionShape.set_collision_mask(0)
	if collisionShape is RigidBody3D:
		collisionShape.freeze = true
		# collisionShape.disabled = true

	pickedObject.global_transform = global_transform
	
	pickedUp = true
	pickingUp = false

func drop():
	if pickedObject == null:
		return

	print("dropping ", collisionShape)
	pickedObject.reparent(get_tree().root.get_child(0,false))

	collisionShape.set_collision_layer(1)
	collisionShape.set_collision_mask(1)
	if collisionShape is RigidBody3D:
		collisionShape.freeze = false	
		# collisionShape.disabled = false
	
	pickedObject = null
	collisionShape = null
	pickedUp = false

func _process(_delta):
	if Input.is_action_just_pressed("pickup-drop"):
		if pickedUp:
			drop()
		else:
			pickUp()
