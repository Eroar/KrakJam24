extends Area3D

# parent of pickupableZone objects
var pickupObject = null
# the collision shape of the pickupObject
var collisionObject = null
var pickingUp = false
var pickedUp = false

func findCollisionObject3D(parentNode:Node) -> CollisionObject3D:
	for node in parentNode.get_children():
		var foundNode = findCollisionObject3D(node)
		if foundNode != null:
			return foundNode
		
		if node is CollisionObject3D:
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
	
	pickupObject = collisions[0].get_parent()
	print("picking up", pickupObject)

	collisionObject = findCollisionObject3D(pickupObject)
	if collisionObject == null:
		push_error("no collision shape found")
		return

	# disable collision and physics on picked up object
	collisionObject.set_collision_layer(0)
	collisionObject.set_collision_mask(0)
	if collisionObject is RigidBody3D:
		collisionObject.freeze = true

	pickupObject.reparent(self)

	var newPosition = get_node("CollisionShape3D").global_position + Vector3(0, 0, 0)
	pickupObject.set_global_position(newPosition)

	pickupObject.transform.basis = transform.basis

	# rotate pickupObject to face player z direction
	# var facingDirection = global_transform.basis.z
	# pickupObject.look_at(facingDirection + facingDirection*2)
	
	pickedUp = true
	pickingUp = false

func drop():
	if pickupObject == null:
		return

	print("dropping ", collisionObject)
	collisionObject.set_collision_layer(1)
	collisionObject.set_collision_mask(1)
	if collisionObject is RigidBody3D:
		collisionObject.freeze = false
	
	pickupObject.reparent(get_tree().root.get_child(0))
	

	pickupObject = null
	collisionObject = null
	pickedUp = false

func _process(_delta):
	if Input.is_action_just_pressed("pickup-drop"):
		if pickedUp:
			drop()
		else:
			pickUp()
