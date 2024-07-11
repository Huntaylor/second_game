extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const FALL_GRAVITY := 1000.0
const GRAVITY := 1500.0

var isDead = false

@onready var damage_sfx = $DamageSFX
@onready var game_manager = %GameManager
@onready var flash_animation = $FlashAnimation
@onready var animated_sprite= $AnimatedSprite2D
@onready var death_timer = $DeathTimer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func get_gravity():
	if velocity.y < 0:
		return GRAVITY
	return FALL_GRAVITY

func _physics_process(delta):
	# Player is dead
	if isDead: 
		if not is_on_floor():
			velocity.y += get_gravity(
				) * delta
			move_and_slide()
		pass
	else:
	# Player is not dead

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
		
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
		
		if Input.is_action_just_released("Jump") and velocity.y < 0:
			velocity.y = JUMP_VELOCITY  / 4
		
		# Flip the Sprite
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
		
		if direction:
			velocity.x = direction * SPEED
			
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()


func _on_game_manager_flash_animation():
	if !isDead:
		flash_animation.play("damage_flash")


func _on_game_manager_player_death():
	if !isDead:
		isDead = true
		animated_sprite.stop()
		animated_sprite.play("death")
		death_timer.start()


func _on_death_timer_timeout():
	get_tree().reload_current_scene()
