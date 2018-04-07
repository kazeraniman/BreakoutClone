extends Sprite

signal brick_destroyed

var health = 1

func brick_collision():
	health -= 1
	if health <= 0:
		emit_signal("brick_destroyed")
		queue_free()

func _on_BrickSides_area_entered(area):
	brick_collision()

func _on_BrickTopBottom_area_entered(area):
	brick_collision()
