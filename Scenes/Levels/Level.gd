extends Node

signal no_more_bricks

var brick_count

func _ready():
	for brick in get_children():
		brick.connect("brick_destroyed", self, "check_no_more_bricks")
	brick_count = get_child_count()

func check_no_more_bricks():
	brick_count -= 1
	if brick_count <= 0:
		emit_signal("no_more_bricks")
