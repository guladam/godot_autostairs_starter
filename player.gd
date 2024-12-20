extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		# Flip the sprite according to new direction
		$AnimatedSprite2D.flip_h = sign(velocity.x) == -1
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	# Play appropriate animation
	if velocity.y < 0:
		$AnimatedSprite2D.play("jump")
	elif is_equal_approx(velocity.x, 0.0):
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("walk")
	
	move_and_slide()
