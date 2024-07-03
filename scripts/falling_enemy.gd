extends Node2D

@onready var ray_cast_down = $RayCastDown
@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer
@onready var collision_shape_2d = $EnemyZone/CollisionShape2D

const direction =1
const dropSpeed = 200
var hasPlayerPassed = false
var isFalling = false

func _ready():
	animated_sprite.play("idle")

func _process(_delta):
	if isFalling:
		position.y += direction * dropSpeed * _delta
	if ray_cast_down.is_colliding() and !hasPlayerPassed:
		_dropEnemy()
		print('Pass')
		

func _dropEnemy():
	timer.start()
	hasPlayerPassed = true
	isFalling = true
	animated_sprite.play("falling")
	
	

