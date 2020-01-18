extends Node2D

var lives = 3

func _ready():
	add_to_group("Gamestate")
	update_gui()
	pass

func hurt():
	lives -= 1
	$Player.hurt()
	if (lives < 1):
		end_game()
	update_gui()
	pass

func update_gui():
	get_tree().call_group("GUI", "update_lives", lives)
	pass

func end_game():
	get_tree().change_scene("res://Levels/GameOver.tscn")
	pass