extends Node

var lives = 3
var score = 0

var ball_scene
var paddle_scene

var paddle

func _ready():
	# Load the needed scenes
	ball_scene = load("res://Scenes/Ball/Ball.tscn")
	paddle_scene = load("res://Scenes/Paddle/Paddle.tscn")
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
	# Create an inital ball
	create_ball()
	# Create a paddle for the player
	paddle = paddle_scene.instance()
	add_child(paddle)

func game_over():
	# Show the menu overlay
	$MenuScreen.show()
	# Destroy the player paddle
	paddle.queue_free()

func create_ball():
	var ball = ball_scene.instance()
	ball.connect("death", self, "_on_Ball_death")
	add_child(ball)
