extends Area3D

# parent of pickupableZone objects
var pickupObject = null
# the collision shape of the pickupObject
var collisionObject = null
var pickedUp = false

func _on_area_entered(area:Area3D):
	if area.is_in_group("pickupable"):
		pickupObject = area.get_parent()
		print("pickupable entered")

func _on_area_exited(area:Area3D):
	if area.is_in_group("pickupable") && pickedUp==false:
		pickupObject = null
		collisionObject = null
		print("pickupable exited")

func findCollisionObject3D(parentNode:Node) -> CollisionObject3D:
	for node in parentNode.get_children():
		var foundNode = findCollisionObject3D(node)
		if foundNode != null:
			return foundNode
		
		if node is CollisionObject3D:
			return node
	return null

func onPickup():
	if pickupObject == null or pickedUp:
		return

	print("picking up")
	pickedUp = true

	collisionObject = findCollisionObject3D(pickupObject)
	if collisionObject == null:
		push_error("no collision shape found")
		print("no collision shape found")
		return

	print("collisionObject", collisionObject)
	print("pickupObject", pickupObject)
	# disable collision and physics on picked up object
	collisionObject.set_collision_layer(0)
	collisionObject.set_collision_mask(0)
	if collisionObject is RigidBody3D:
		collisionObject.freeze = true

	pickupObject.set_global_position(get_node("CollisionShape3D").global_position)
	pickupObject.reparent(self)

	

func onDrop():
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
			onDrop()
		else:
			onPickup()
