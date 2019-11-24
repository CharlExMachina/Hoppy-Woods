extends AnimatedSprite

func _on_Player_animate(motion : Vector2, is_on_floor : bool) -> void:
	if motion.y < 0:
		play("jump")
	elif motion.y > 0:
		play("fall")
	elif motion.x != 0 and is_on_floor:
		set_flip_h(motion.x < 0)
		play("run")
	elif motion.x == 0 and motion.y == 0 and is_on_floor:
		play("idle")
	pass