extends CharacterBody2D

@onready var jump_ray_cast = $JumpRayCast
@onready var game_manager = %GameManager
@onready var left_ray_cast = $LeftRayCast
@onready var right_ray_cast = $RightRayCast
@onready var animated_sprite = $AnimatedSprite2D

const speed = 60
var jumped = false
var direction = -1
var previousDirection = 1
const JUMP_VELOCITY = -300.0
const FALL_GRAVITY := 1000.0
const GRAVITY := 1500.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	add_to_group('enemies')
	
func get_gravity():
	if velocity.y < 0:
		return GRAVITY
	return FALL_GRAVITY
	
func _physics_process(_delta):
	if right_ray_cast.is_colliding():
		direction = -1
		animated_sprite.flip_h = false
		
	if left_ray_cast.is_colliding():
		direction = 1
		animated_sprite.flip_h = true
	
	if not is_on_floor():
			velocity.y += get_gravity(
			) * _delta
	
	if is_on_floor() and jump_ray_cast.is_colliding():
		jumped = true
		previousDirection = direction
		direction = 0
		velocity.y = JUMP_VELOCITY
	elif jumped and is_on_floor():
		jumped = false
		direction =previousDirection
	position.x += direction * speed * _delta
	
	move_and_slide()

func _on_enemy_zone_take_damage():
	game_manager.take_damage()

