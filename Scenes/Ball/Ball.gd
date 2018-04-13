extends Area2D

signal death

var speed = 200
var velocity = Vector2(0, 0)
var launched = false
var screen_size

var bounce_left_entities = ["RightWall", "BrickLeft"]
var bounce_right_entities = ["LeftWall", "BrickRight"]
var bounce_up_entities = ["Paddle", "BrickTop"]
var bounce_down_entities = ["Ceiling", "BrickBottom"]

func _ready():
	screen_size = get_viewport_rect().size
	position = screen_size / 2

func _process(delta):
	if launched:
		var normalized_velocity = velocity.normalized()
		position += normalized_velocity * speed * delta

func _on_Ball_area_entered(area):
	# Cause a bounce to the left
	if area.get_name() in bounce_left_entities:
		velocity.x = abs(velocity.x) * -1
	# Cause a bounce to the right
	if area.get_name() in bounce_right_entities:
		velocity.x = abs(velocity.x)
	# Cause a bounce upward
	if area.get_name() in bounce_up_entities:
		velocity.y = abs(velocity.y) * -1
	# Cause a bounce downward
	if area.get_name() in bounce_down_entities:
		velocity.y = abs(velocity.y)
	# Hit the death zone
	if area.get_name() == "DeathZone":
		emit_signal("death")
		queue_free()
	# If we hit the paddle, additionally give more control and change the horizontal to give more control
	if area.get_name() == "Paddle":
		var paddle_width = area.get_node("Sprite").region_rect.size.x / 4
		var contact_position = clamp((position.x - area.position.x) / paddle_width, -2, 2)
		velocity.x = contact_position

func _on_LaunchTimer_timeout():
	var launch_target_x = randi() % int(round(screen_size.x))
	var launch_target_point = Vector2(launch_target_x, 720)
	var launch_direction = launch_target_point - position
	velocity = launch_direction.normalized()
	launched = true
