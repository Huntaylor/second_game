extends Area2D





func _on_body_entered(body):
	print("Health restored!")
	
	queue_free()
