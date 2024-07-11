extends Area2D
signal take_damage

var damagePlayer = false

func _process(delta):
	if damagePlayer:
		emit_signal('take_damage')

func _on_body_entered(_body):
	if (_body.name == 'Player'):
		damagePlayer = true
		emit_signal('take_damage')


func _on_body_exited(_body):
	if (_body.name == 'Player'):
		damagePlayer = false
