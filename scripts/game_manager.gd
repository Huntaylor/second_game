extends Node
var lives = 3
var lifeTaken = false

func take_life():
	lifeTaken = true
	lives = lives - 1
	print(lives)
	if lives <= 0:
		print('You died')
