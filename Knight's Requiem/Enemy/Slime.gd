extends KinematicBody2D

const GRAVITY = 35

export var horizontal_speed = 250 # if negative, it will start moving right
export var i_time = 3 # seconds before it can damage the player again

#preload the explosion effect
var explosion_fx = preload("res://EnemyExplosion/EnemyExplosion.tscn")

var UP = Vector2(0, -10)
var velocity = Vector2(0, 0)

func _physics_process(delta):
	horizontal_movement()
	apply_gravity()
	velocity = move_and_slide(velocity, UP)
	pass

func apply_gravity():
	velocity.y += GRAVITY
	pass

func horizontal_movement():
	velocity.x = horizontal_speed
	if is_on_wall():
		if (horizontal_speed > 0): #so it doesn't go haywire when it collides
			position.x -= 1
		else:
			position.x += 1
		
		flip_hspeed()
	
	$Sprite.set_flip_h(horizontal_speed > 0)
	pass

func hurt_player():
	get_tree().call_group("Gamestate", "hurt")
	pass

func _on_Area2D_body_entered(body):
	get_tree().call_group("Gamestate", "hurt")
	pass

func flip_hspeed():
	horizontal_speed *= -1
	pass

func _on_WeakspotArea_was_stomped():
	var explosion_instance = explosion_fx.instance()
	explosion_instance.position = position
	get_tree().root.add_child(explosion_instance)
	queue_free()
	pass
