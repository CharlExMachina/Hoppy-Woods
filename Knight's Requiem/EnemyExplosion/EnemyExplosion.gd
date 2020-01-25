extends AnimatedSprite

func _ready():
	play("explode")
	pass

func _on_EnemyExplosion_animation_finished():
	queue_free()
	pass
