extends Area2D
signal take_damage



func _on_body_entered(_body):
	if (_body.name == 'Player'):
		emit_signal('take_damage')





