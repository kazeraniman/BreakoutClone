extends Area2D

var speed = 200
var velocity = Vector2(1, 1)
var screen_size

var horizontal_entities = ["LeftWall", "RightWall", "BrickSides"]
var vertical_entities = ["Ceiling", "Paddle", "BrickTopBottom"]

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var normalized_velocity = velocity.normalized()
	position += normalized_velocity * speed * delta

func _on_Ball_area_entered(area):
	# Bounce off of the side of something
	if area.get_name() in horizontal_entities:
		velocity.x *= -1
	# Bounce on the top or bottom of something
	if area.get_name() in vertical_entities:
		velocity.y *= -1
	# Hit the death zone
	if area.get_name() == "DeathZone":
		position = screen_size / 2
	# If we hit the paddle, additionally give more control and change the horizontal to give more control
	if area.get_name() == "Paddle":
		var paddle_width = area.get_node("Sprite").region_rect.size.x / 4
		var contact_position = clamp((position.x - area.position.x) / paddle_width, -2, 2)
		velocity.x = contact_position
