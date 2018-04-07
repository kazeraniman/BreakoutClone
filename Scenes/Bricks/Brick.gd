extends Sprite

signal brick_destroyed

export (int) var health
var hittable = true

func _ready():
	set_brick_texture_per_level()

func set_brick_texture_per_level():
	match health:
		3:
			set_region_rect(Rect2(208, 192, 48, 16))
		2:
			set_region_rect(Rect2(208, 160, 48, 16))
		_:
			set_region_rect(Rect2(208, 32, 48, 16))

func brick_collision():
	if hittable:
		hittable = false
		$HittableTimout.start()
		health -= 1
		set_brick_texture_per_level()
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
