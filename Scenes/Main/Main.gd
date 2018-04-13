extends Node

var LEVEL_COUNT = 3

var lives = 3
var score = 0

var ball_scene
var paddle_scene

var ball
var paddle
var level

func _ready():
	# Prepare the random seed
	randomize()
	# Load the always-needed scenes
	ball_scene = load("res://Scenes/Ball/Ball.tscn")
	paddle_scene = load("res://Scenes/Paddle/Paddle.tscn")
	# Start the music
	$MenuMusic.play()

func _on_Ball_death():
	lives -= 1
	$HUD.set_lives(lives)
	$DeathSound.play()
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
	# Create a paddle for the player
	paddle = paddle_scene.instance()
	add_child(paddle)
	# Generate a new level
	generate_level()
	# Create an inital ball
	create_ball()
	# Change up the music
	$MenuMusic.stop()
	$GameMusic.play()

func game_over():
	# Show the menu overlay
	$MenuScreen.show()
	# Destroy the ball
	ball.queue_free()
	# Destroy the player paddle
	paddle.queue_free()
	# Destroy the level
	level.queue_free()
	# Change up the music
	$GameMusic.stop()
	$MenuMusic.play()

func brick_broken():
	$BrickBreakSound.play()
	increase_score()

func create_ball():
	ball = ball_scene.instance()
	ball.connect("death", self, "_on_Ball_death")
	add_child(ball)

func generate_level():
	# Create a random level from the possible levels
	var level_choice = randi() % (LEVEL_COUNT) + 1
	var level_scene = load("res://Scenes/Levels/Level" + str(level_choice) + ".tscn")
	level = level_scene.instance()
	# Listen for the brick_destroyed signal from all the bricks in the level
	for brick in level.get_children():
		brick.connect("brick_destroyed", self, "brick_broken")
	level.connect("no_more_bricks", self, "next_game")
	add_child(level)

func next_game():
	# Celebratory jingle
	$RoundWinSound.play()
	# Free the old resources
	ball.queue_free()
	paddle.queue_free()
	level.queue_free()
	# Generate new resources
	paddle = paddle_scene.instance()
	add_child(paddle)
	generate_level()
	create_ball()
