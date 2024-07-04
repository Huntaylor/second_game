extends Node2D

@onready var ray_cast_left = $RayCastLeft
@onready var timer = $Timer

var rotationSpeed = -2
var shouldRotate = false
var direction = -1
var attackSpeed = 30
var rotationMax = 25
var attackSpeedMax = 375


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shouldRotate:
		rotation += rotationSpeed * delta
		position.x += direction * attackSpeed * delta
	if ray_cast_left.is_colliding():
		timer.start()
		shouldRotate = true



func _on_timer_timeout():
	if rotationSpeed <= rotationMax:
		rotationSpeed = rotationSpeed * 1.5
	if attackSpeed <= attackSpeedMax:
		attackSpeed = attackSpeed * 1.5
