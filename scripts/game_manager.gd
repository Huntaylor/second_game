extends Node

@onready var timer = $Timer

signal flash_animation
signal player_death

var speed = 0

var lives = 3
var isHit = false

func take_damage():
	if !isHit:
		isHit = true
		timer.start()
		emit_signal('flash_animation')
		lives = lives - 1
		if lives <= 0:
			emit_signal('player_death')

func _on_timer_timeout():
	isHit = false

func _ready():
	pass
