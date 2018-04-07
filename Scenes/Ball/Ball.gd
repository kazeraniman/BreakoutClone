extends Area2D

var speed
var velocity = Vector2()
var screen_size

var horizontal_entities = ["LeftWall", "RightWall", "BrickSides"]
var vertical_entities = ["Ceiling", "Paddle", "BrickTopBottom"]

func _ready():
	speed = 200
	velocity.x = 1
	velocity.y = 1
	velocity = velocity.normalized() 
	screen_size = get_viewport_rect().size

func _process(delta):
	position += velocity * speed * delta

func _on_Ball_area_entered(area):
	if area.get_name() in horizontal_entities:
		velocity.x *= -1
	if area.get_name() in vertical_entities:
		velocity.y *= -1
	if area.get_name() == "DeathZone":
		position = screen_size / 2
