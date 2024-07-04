extends Area2D
@onready var timer = $Timer

var lives = 3
var lifeTaken = false

func _on_body_entered(_body):
	if lifeTaken == false and lives > 0:
		timer.start()
		take_life()
		lifeTaken = true

func take_life():
	lives = lives -1
	print(lives)
	if lives <= 0:
		print('You died')


func _on_timer_timeout():
	lifeTaken = false
