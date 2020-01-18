extends CanvasLayer

func update_lives(lives):
	$Control/TextureRect/HBoxContainer/LivesLabel.text = "x" + str(lives)
	pass
