extends Area2D
@onready var timer = $Timer
@onready var game_manager = %GameManager


func _on_body_entered(_body):
	if game_manager.lifeTaken == false and game_manager.lives > 0:
		timer.start()
		game_manager.take_life()



func _on_timer_timeout():
	game_manager.lifeTaken = false
