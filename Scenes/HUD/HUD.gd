extends CanvasLayer

var full_heart_texture = load("res://Art/full_heart.png")
var empty_heart_texture = load("res://Art/empty_heart.png")

func _ready():
	set_lives(3)

func set_lives(lives):
	# TODO: Should be able to iterate over children instead of explicit setting.
	match lives:
		3:
			$MarginContainer/NinePatchRect/HeartContainer/Heart1.texture = full_heart_texture
			$MarginContainer/NinePatchRect/HeartContainer/Heart2.texture = full_heart_texture
			$MarginContainer/NinePatchRect/HeartContainer/Heart3.texture = full_heart_texture
		2:
			$MarginContainer/NinePatchRect/HeartContainer/Heart1.texture = empty_heart_texture
			$MarginContainer/NinePatchRect/HeartContainer/Heart2.texture = full_heart_texture
			$MarginContainer/NinePatchRect/HeartContainer/Heart3.texture = full_heart_texture
		1:
			$MarginContainer/NinePatchRect/HeartContainer/Heart1.texture = empty_heart_texture
			$MarginContainer/NinePatchRect/HeartContainer/Heart2.texture = empty_heart_texture
			$MarginContainer/NinePatchRect/HeartContainer/Heart3.texture = full_heart_texture
		_:
			$MarginContainer/NinePatchRect/HeartContainer/Heart1.texture = empty_heart_texture
			$MarginContainer/NinePatchRect/HeartContainer/Heart2.texture = empty_heart_texture
			$MarginContainer/NinePatchRect/HeartContainer/Heart3.texture = empty_heart_texture
