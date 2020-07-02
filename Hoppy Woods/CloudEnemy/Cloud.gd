extends Node2D

var lightning = preload("res://CloudEnemy/Lightning.tscn")

func shoot_lightning_bolt():
	var lightning_instance = lightning.instance()
	var pos = $Sprite.position + Vector2(0, 25)
	lightning_instance.position = pos
	add_child(lightning_instance)
	pass
