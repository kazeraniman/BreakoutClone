extends Node

var lives = 3

func _on_Ball_death():
	lives -= 1
	$HUD.set_lives(lives)
