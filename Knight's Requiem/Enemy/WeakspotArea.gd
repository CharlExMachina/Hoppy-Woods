extends Area2D

signal was_stomped

func die():
	emit_signal("was_stomped")
	pass