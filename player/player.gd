extends CharacterBody3D


@export var MOVEMENT_SPEED = 8.0
@export var ROTATION_SPEED = 5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()
	if direction:
		velocity.x = direction.x * MOVEMENT_SPEED
		velocity.z = direction.z * MOVEMENT_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MOVEMENT_SPEED)
		velocity.z = move_toward(velocity.z, 0, MOVEMENT_SPEED)

	if velocity.length() > 0 && velocity.y == 0:
		var target_direction = transform.origin - velocity
		var target_rotation = transform.looking_at(target_direction, Vector3.UP).basis
		transform.basis = transform.basis.slerp(target_rotation, delta * ROTATION_SPEED)

	move_and_slide()
