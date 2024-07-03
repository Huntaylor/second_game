extends Node2D

@onready var ray_cast_down = $RayCastDown
@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer
@onready var collision_shape_2d = $EnemyZone/CollisionShape2D
@onready var ray_cast_up = $RayCastUp


var direction =1
const dropSpeed = 200
const riseSpeed = 100
var hasPlayerPassed = false
var isFalling = false
var isGoingUp = false
var location = position

func _ready():
	location = position
	animated_sprite.play("idle")

func _process(_delta):

	if isGoingUp and !(position.y <= location.y):
			position.y += direction * riseSpeed * _delta
	if isFalling:
		position.y += direction * dropSpeed * _delta
		if ray_cast_up.is_colliding():
			_goUp()
	if ray_cast_down.is_colliding() and !hasPlayerPassed and !isGoingUp:
		_dropEnemy()
		print('Pass')
		

func _dropEnemy():
	direction = 1
	timer.start()
	hasPlayerPassed = true
	isFalling = true
	animated_sprite.play("falling")
	
	
func _goUp():
	direction = -1
	isGoingUp = true
	isFalling = false
