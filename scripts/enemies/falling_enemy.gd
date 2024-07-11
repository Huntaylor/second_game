extends Node2D

@onready var ray_cast_down = $RayCastDown
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape_2d = $EnemyZone/CollisionShape2D
@onready var ray_cast_up = $RayCastUp
@onready var timer = $Timer
@onready var game_manager = %GameManager


var direction = 1
const dropSpeed = 200
const riseSpeed = 100
var hasPlayerPassed = false
var isFalling = false
var location = position
var backInPosition = true

func _ready():
	add_to_group('enemies')
	location = position
	animated_sprite.play("idle")
	backInPosition = position.y <= location.y

	

func _process(_delta):
	backInPosition = position.y <= location.y

	if !isFalling and !backInPosition:
			position.y += direction * riseSpeed * _delta
	if isFalling:
		position.y += direction * dropSpeed * _delta
		if ray_cast_up.is_colliding():
			isFalling= false
			timer.start()
			direction = 0
	if ray_cast_down.is_colliding() and !hasPlayerPassed and !isFalling and backInPosition:
		_dropEnemy()
		

func _dropEnemy():
	direction = 1
	hasPlayerPassed = true
	isFalling = true
	animated_sprite.play("falling")
	
	
func _goUp():
	animated_sprite.play("idle")
	hasPlayerPassed =false
	direction = -1
	isFalling = false

func _on_timer_timeout():
	_goUp()



func _on_enemy_zone_take_damage():
	game_manager.take_damage()
