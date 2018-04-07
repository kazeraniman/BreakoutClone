extends Area2D

var speed
var screen_size

func _ready():
	speed = 300
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2()
	
	# Get the current inputs provided
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	
	# Only move if there is a button being pressed
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	
	# Make sure the paddle stays on screen
	var sprite_extent = $Sprite.region_rect.size.x / 2
	position.x = clamp(position.x, 0 + sprite_extent, screen_size.x - sprite_extent)
