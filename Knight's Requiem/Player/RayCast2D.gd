extends RayCast2D



func _on_Player_stomp_enemy():
	get_collider().die()
	pass
