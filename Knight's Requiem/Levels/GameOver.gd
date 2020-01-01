extends Control

func _on_PlayButton_pressed():
	get_tree().change_scene("res://Levels/Level1.tscn")
	pass

func _on_ExitButton_pressed():
	get_tree().quit()
	pass
