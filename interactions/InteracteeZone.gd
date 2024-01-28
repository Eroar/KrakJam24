extends Area3D

@export var KICK_FORCE_FORWARD = 10
@export var KICK_FORCE_UP = 10

# parent of pickupableZone objects
var package = null
# the collision shape of the package
var packageRigid = null

# internal flags
var pickingUp = false

func hasPackage()->bool:
	return package != null

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
	if hasPackage() || pickingUp:
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
	
	pickingUp = false


func drop():
	if !hasPackage():
		return

	print("dropping ", packageRigid)
	package.reparent(get_tree().root.get_child(0,false))
	
	var tempRigid = packageRigid

	unlinkPackage()

	kick(tempRigid)
	
func kick(node:RigidBody3D):
	if node == null:
		return

	node.apply_impulse(global_transform.basis.z*KICK_FORCE_FORWARD + Vector3.UP*KICK_FORCE_UP, Vector3(0,0,0))


func unlinkPackage():
	if !hasPackage():
		return
	packageRigid.set_collision_layer(1)
	packageRigid.set_collision_mask(1)
	if packageRigid is RigidBody3D:
		packageRigid.freeze = false	
	package = null
	packageRigid = null


func startInteraction():
	var collisions = get_overlapping_areas()
	collisions = collisions.filter(func(x): return x.is_in_group("interactable"))

	# no interactable object in range
	if collisions.size() == 0:
		print("no interactable object in range")
		return
	
	var interactableObject = collisions[0]
	interactableObject.emit_signal("interaction_start", package, self)

func stopInteraction():
	var collisions = get_overlapping_areas()
	collisions = collisions.filter(func(x): return x.is_in_group("interactable"))

	# no interactable object in range
	if collisions.size() == 0:
		print("no interactable object in range")
		return
	
	var interactableObject = collisions[0]
	interactableObject.emit_signal("interaction_stop", package, self)

func _process(_delta):
	if Input.is_action_just_pressed("pickup-drop"):
		if hasPackage():
			drop()
		else:
			pickUp()
	elif Input.is_action_just_pressed("interact"):
		startInteraction()
	elif Input.is_action_just_released("interact"):
		stopInteraction()
