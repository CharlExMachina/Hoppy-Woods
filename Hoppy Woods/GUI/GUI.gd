extends CanvasLayer

func update_lives(lives):
	$Control/TextureRect/HBoxContainer/LivesLabel.text = "x" + str(lives)
	pass

func update_cherries(amount):
	$Control/CherriesLabel.text = str(amount)
	pass

func play_extra_life_sound():
	$AudioStreamPlayer.play()
	pass

func update_one_ups(amount):
	$Control/PlayerOneUps.text = "Lives: " + str(amount)
