extends CharacterBody2D

@onready var jump_ray_cast = $JumpRayCast
@onready var game_manager = %GameManager

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
	if not is_on_floor():
			velocity.y += get_gravity(
			) * _delta
			
	if is_on_floor() and jump_ray_cast.is_colliding():
		print('jump')
		velocity.y = JUMP_VELOCITY
	move_and_slide()

func _on_enemy_zone_take_damage():
	game_manager.take_damage()

