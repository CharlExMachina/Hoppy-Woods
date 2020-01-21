extends CanvasLayer

func update_lives(lives):
	$Control/TextureRect/HBoxContainer/LivesLabel.text = "x" + str(lives)
	pass

func update_cherries(amount):
	$Control/CherriesLabel.text = str(amount)
	pass
