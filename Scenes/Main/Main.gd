extends Node

var lives = 3
var score = 0

var ball_scene

func _ready():
	# Load the ball scene
	ball_scene = load("res://Scenes/Ball/Ball.tscn")
	# Listen for the brick_destroyed signal from all the bricks
	for brick in $Bricks.get_children():
		brick.connect("brick_destroyed", self, "increase_score")

func _on_Ball_death():
	lives -= 1
	$HUD.set_lives(lives)
	if lives > 0:
		create_ball()
	else:
		game_over()

func increase_score():
	score += 100
	$HUD/Score.text = str(score)

func _on_MenuScreen_play_game():
	# Hide the menu overlay
	$MenuScreen.hide()
	# Reset the score
	score = 0
	$HUD/Score.text = str(score)
	# Reset the lives
	lives = 3
	$HUD.set_lives(lives)
	# Create a ball to get started
	create_ball()

func game_over():
	# Show the menu overlay
	$MenuScreen.show()

func create_ball():
	var ball = ball_scene.instance()
	ball.connect("death", self, "_on_Ball_death")
	add_child(ball)
