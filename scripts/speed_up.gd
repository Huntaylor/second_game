extends Area2D

@onready var timer = $Timer


func _on_body_entered(body):
	if (body.name == 'Player'):
		Engine.time_scale = 2
		timer.start()
func _on_timer_timeout():
	Engine.time_scale = 1
	queue_free()


	

