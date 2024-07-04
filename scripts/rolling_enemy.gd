extends Node2D
@onready var ray_cast_left = $RayCastLeft
var rotationSpeed = 50
var shouldRotate = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shouldRotate:
		rotation += rotationSpeed * delta
	if ray_cast_left.is_colliding():
		shouldRotate = true
