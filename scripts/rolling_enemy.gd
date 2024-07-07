extends Node2D

@onready var game_manager = %GameManager

@onready var timer = $Timer
@onready var sprite_2d = $Sprite2D
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_left_stop = $RayCastLeftStop
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_right_stop = $RayCastRightStop

var rotationSpeed = -2
var isMovingLeft = false
var isMovingRight = false
var isStopped = true
var direction = -1
var attackSpeed = 30
var rotationMax = 20
var attackSpeedMax = 350


func _process(delta):
	if !isStopped:
		sprite_2d.rotation += rotationSpeed * delta
		position.x += direction * attackSpeed * delta

	if ray_cast_left.is_colliding() and isStopped:
		rotationSpeed = -2
		direction = -1
		timer.start()
		isMovingLeft = true
		isStopped = false

	if ray_cast_right.is_colliding() and isStopped:
		rotationSpeed = 2
		direction = 1
		timer.start()
		isStopped = false
		isMovingRight = true

	if ray_cast_left_stop.is_colliding() and !isStopped and !isMovingRight:
		timer.stop()
		_reset()

	if ray_cast_right_stop.is_colliding() and !isStopped and !isMovingLeft:
		timer.stop()
		_reset()


func _reset():
	isMovingLeft = false
	isMovingRight = false
	isStopped = true
	attackSpeed = 30

func _on_timer_timeout():
	if rotationSpeed <= rotationMax:
		rotationSpeed = rotationSpeed * 1.5
	if attackSpeed <= attackSpeedMax:
		attackSpeed = attackSpeed * 1.5


func ready():
	add_to_group('enemies')

func _on_enemy_zone_take_damage():
	game_manager.take_damage()
