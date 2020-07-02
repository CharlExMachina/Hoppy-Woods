extends Node2D

var taken = false

func _on_Area2D_body_entered(body):
	if not taken:
		taken = true
		$AnimationPlayer.play("die")
		$AudioStreamPlayer2D.play()
		get_tree().call_group("Gamestate", "cherry_up")
	pass

func die():
	queue_free()
	pass
