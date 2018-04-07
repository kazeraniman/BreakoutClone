extends Sprite

signal brick_destroyed

export (int) var health
var hittable = true

func brick_collision():
	if hittable:
		hittable = false
		$HittableTimout.start()
		health -= 1
		if health <= 0:
			emit_signal("brick_destroyed")
			queue_free()

func _on_BrickSides_area_entered(area):
	# Turn off collisions so we don't get multi hits.
	$BrickSides/CollisionLeft.disabled = true
	$BrickSides/CollisionRight.disabled = true
	$BrickSides/CollisionTimeout.start()
	# Apply collision logic
	brick_collision()

func _on_BrickTopBottom_area_entered(area):
		# Turn off collisions so we don't get multi hits.
	$BrickTopBottom/CollisionTop.disabled = true
	$BrickTopBottom/CollisionBottom.disabled = true
	$BrickSides/CollisionTimeout.start()
	# Apply collision logic
	brick_collision()

func _on_BrickSides_CollisionTimeout_timeout():
	# Re-enable collision detection
	$BrickSides/CollisionLeft.disabled = false
	$BrickSides/CollisionRight.disabled = false

func _on_BrickTopBottom_CollisionTimeout_timeout():
	# Re-enable collision detection
	$BrickTopBottom/CollisionTop.disabled = false
	$BrickTopBottom/CollisionBottom.disabled = false

func _on_HittableTimout_timeout():
	hittable = true
