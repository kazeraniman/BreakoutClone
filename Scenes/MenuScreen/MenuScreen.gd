extends CanvasLayer

signal play_game

func _on_Play_pressed():
	emit_signal("play_game")

func show():
	$Title.show()
	$Play.show()

func hide():
	$Title.hide()
	$Play.hide()
