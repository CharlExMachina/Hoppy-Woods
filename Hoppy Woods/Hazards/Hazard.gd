extends Area2D

func _on_SpikeTop_body_entered(body):
	if body.get_collision_layer_bit(0):
		get_tree().call_group("Gamestate", "hurt")
	pass
