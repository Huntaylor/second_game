extends Node

signal flash_animation
signal player_death

var lives = 3

func take_damage():
	emit_signal('flash_animation')
	lives = lives - 1
	if lives <= 0:
		emit_signal('player_death')

