extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const FALL_GRAVITY := 1000.0
const GRAVITY := 1500.0


@onready var animated_sprite= $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func get_gravity():
	if velocity.y < 0:
		return GRAVITY
	return FALL_GRAVITY

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += get_gravity(
		) * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Move_left", "Move_right")
	
	if Input.is_action_just_released("Jump") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY  / 4
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = true
	elif direction < 0:
		animated_sprite.flip_h = false
	

	
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
	
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
