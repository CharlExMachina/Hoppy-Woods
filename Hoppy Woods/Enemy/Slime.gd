extends KinematicBody2D

const GRAVITY = 35

export var horizontal_speed = 250 # if negative, it will start moving right
export var i_time = 3 # seconds before it can damage the player again

onready var left_ground_checker: RayCast2D = $Raycasts/Left
onready var right_ground_checker: RayCast2D = $Raycasts/Right

#preload the explosion effect
var explosion_fx = preload("res://EnemyExplosion/EnemyExplosion.tscn")

var velocity = Vector2(0, 0)
var check_floor = true

func _physics_process(delta):
	horizontal_movement()
	apply_gravity()
	velocity = move_and_slide(velocity, Vector2.UP)
	check_for_boundaries()
	check_wall_collision()
	pass

func check_for_boundaries():
	if not left_ground_checker.is_colliding() or not right_ground_checker.is_colliding():
		if check_floor:
			flip_hspeed()
			check_floor = false
	
	if left_ground_checker.is_colliding() and right_ground_checker.is_colliding() and not check_floor:
		check_floor = true
	pass

func apply_gravity():
	velocity.y += GRAVITY
	pass

func horizontal_movement():
	velocity.x = horizontal_speed
	$Sprite.set_flip_h(horizontal_speed > 0)
	pass

func check_wall_collision():
	if is_on_wall():
		if (horizontal_speed > 0): #so it doesn't go haywire when it collides
			position.x -= 1
		else:
			position.x += 1

		flip_hspeed()
	pass

func hurt_player():
	get_tree().call_group("Gamestate", "hurt")
	pass

func _on_Area2D_body_entered(body):
#	if body.get_collision_layer() == 1:
	if body.get_collision_layer_bit(0):
		hurt_player()
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
