extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $DamageBar
@onready var game_manager = %GameManager


var health = 0





func _on_timer_timeout():
	damage_bar.value =  health



func _on_player_call_healthbar(new_health):
	print(new_health)
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	health = new_health
	if health <= 0:
		queue_free()
	
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health

	pass # Replace with function body.


func _on_player_set_healthbar(init_health):
	health = init_health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health
	#init_health = health
	#health = min(max_value, new_health)
	#value = health
	#
	#if health <= 0:
		#queue_free()
	#
	#if health < prev_health:
		#timer.start()
	#else:
		#damage_bar.value = health
	#
	pass # Replace with function body.
