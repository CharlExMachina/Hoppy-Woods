extends Node2D

export var next_level : String = ""

var lives = 3
var cherries = 0
var extra_live_threshold = 10

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
	if cherries % extra_live_threshold == 0:
		lives += 1
		get_tree().call_group("GUI", "play_extra_life_sound")
	update_gui()
	pass

func update_gui():
	get_tree().call_group("GUI", "update_lives", lives)
	get_tree().call_group("GUI", "update_cherries", cherries)
	pass

func end_game():
	get_tree().change_scene("res://Levels/GameOver.tscn")
	pass

func win_game():
	if not next_level == "":
		get_tree().change_scene(next_level)
	pass
