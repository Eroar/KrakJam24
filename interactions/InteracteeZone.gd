extends Area3D

# parent of pickupableZone objects
var package = null
# the collision shape of the package
var packageRigid = null

# internal flags
var pickingUp = false
var pickedUp = false

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
	
	package = collisions[0].get_parent()
	print("picking up", package)

	packageRigid = findRigidBody3D(package)
	if packageRigid == null:
		push_error("no collision shape found")
		return

	package.reparent(self)

	# disable collision and physics on picked up object
	packageRigid.set_collision_layer(0)
	packageRigid.set_collision_mask(0)
	if packageRigid is RigidBody3D:
		packageRigid.freeze = true
		# packageRigid.disabled = true


	package.global_transform = global_transform
	
	pickedUp = true
	pickingUp = false

func kick():
	if package == null:
		return
	
	packageRigid.apply_impulse(Vector3.FORWARD, Vector3(0,0,0))

func drop():
	if package == null:
		return

	print("dropping ", packageRigid)
	package.reparent(get_tree().root.get_child(0,false))

	packageRigid.set_collision_layer(1)
	packageRigid.set_collision_mask(1)
	if packageRigid is RigidBody3D:
		packageRigid.freeze = false	

	packageRigid.apply_impulse(global_transform.basis.z*10 + Vector3.UP*10, Vector3(0,0,0))
	
	package = null
	packageRigid = null
	pickedUp = false

func tryToInteract():
	var collisions = get_overlapping_areas()
	collisions = collisions.filter(func(x): return x.is_in_group("interactable"))

	# no interactable object in range
	if collisions.size() == 0:
		print("no interactable object in range")
		return
	
	var interactableObject = collisions[0]
	interactableObject.emit_signal("interaction_requested", package)

func _process(_delta):
	if Input.is_action_just_pressed("pickup-drop"):
		if pickedUp:
			drop()
		else:
			pickUp()
	elif Input.is_action_just_pressed("interact"):
		tryToInteract()
	elif Input.is_action_just_pressed("kick"):
		kick()
	
