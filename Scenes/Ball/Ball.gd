extends Area2D

var speed
var velocity = Vector2()
var screen_size

func _ready():
	speed = 200
	velocity.x = 1
	velocity.y = 1
	velocity = velocity.normalized() 
	screen_size = get_viewport_rect().size

func _process(delta):
	position += velocity * speed * delta

func _on_Ball_area_entered(area):
	if area.get_name() == "LeftWall" or area.get_name() == "RightWall":
		velocity.x *= -1
	if area.get_name() == "Ceiling" or area.get_name() == "Paddle":
		velocity.y *= -1
	if area.get_name() == "DeathZone":
		position = screen_size / 2
