extends AnimatedSprite

func _on_Player_animate(motion : Vector2, is_on_floor : bool, has_input : bool) -> void:
	if motion.y < 0 and !is_on_floor:
		play("jump")
	elif motion.y > 0 and !is_on_floor:
		play("fall")
	elif is_on_floor and has_input and abs(motion.x) < 1:
		play("idle")
	elif motion.x != 0 and is_on_floor and has_input:
		set_flip_h(motion.x < 0)
		play("run")
	elif is_on_floor and !has_input:
		play("idle")
	pass