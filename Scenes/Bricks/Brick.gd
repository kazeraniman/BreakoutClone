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
		$HittableTimeout.start()
		health -= 1
		set_brick_texture_per_level()
		if health <= 0:
			emit_signal("brick_destroyed")
			queue_free()

func _on_Brick_area_entered(area):
	brick_collision()

func _on_HittableTimeout_timeout():
	hittable = true
