extends Node2D

var lives = 3
var cherries = 0
var extra_live_threshold = 30

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

func cherry_up():
	cherries += 1
	if cherries >= extra_live_threshold:
		lives += 1
		cherries = 0
	update_gui()
	pass

func update_gui():
	get_tree().call_group("GUI", "update_lives", lives)
	get_tree().call_group("GUI", "update_cherries", cherries)
	pass

func end_game():
	get_tree().change_scene("res://Levels/GameOver.tscn")
	pass
