extends Area2D

@onready var game_manager = %GameManager
@onready var healthbar = $Healthbar

signal call_healthbar
signal set_healthbar

var lives = 3
var isHit = false


func _on_body_entered(body):
	print("Health restored!")
	if !isHit:
		isHit = true
		lives = lives + 2
		queue_free()


