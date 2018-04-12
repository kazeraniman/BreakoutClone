extends Node

var lives = 3
var score = 0

func _ready():
	# Listen for the brick_destroyed signal from all the bricks
	for brick in $Bricks.get_children():
		brick.connect("brick_destroyed", self, "increase_score")

func _on_Ball_death():
	lives -= 1
	$HUD.set_lives(lives)

func increase_score():
	score += 100
	$HUD/Score.text = str(score)
