extends Node2D

#preload the explosion effect
var explosion_fx = preload("res://EnemyExplosion/EnemyExplosion.tscn")

func _on_WeakspotArea_was_stomped():
	var explosion_instance = explosion_fx.instance()
	explosion_instance.position = $EagleSprite.global_position
	get_tree().root.add_child(explosion_instance)
	queue_free()
	pass


func _on_DamageArea_body_entered(body):
	if body.get_collision_layer_bit(0):
		get_tree().call_group("Gamestate", "hurt")
	pass
