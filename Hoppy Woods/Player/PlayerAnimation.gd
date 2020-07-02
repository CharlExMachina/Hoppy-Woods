extends AnimatedSprite

func _on_Player_animate(velocity : Vector2, is_grounded : bool, has_input : bool) -> void:
	if !is_grounded:
		if velocity.y < 0:
			play("jump")
		else:
			play("fall")
	elif is_grounded and velocity.x != 0 and has_input:
		flip_h = velocity.x < 0
		play("run")
	else:
		play("idle")
	pass

func _on_Player_player_hurt():
	play("hurt")
	pass
