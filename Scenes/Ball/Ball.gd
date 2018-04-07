extends Area2D

var speed
var velocity = Vector2()

func _ready():
	speed = 5
	velocity.x = 1
	velocity.y = 1
	velocity = velocity.normalized() 

func _process(delta):
	position += velocity * speed

func _on_Ball_area_entered(area):
	if area.get_name() == "LeftWall" or area.get_name() == "RightWall":
		velocity.x *= -1
	if area.get_name() == "Ceiling" or area.get_name() == "DeathZone":
		velocity.y *= -1
#	if area.get_name() == "DeathZone":
#		position.x = 300
#		position.y = 300
