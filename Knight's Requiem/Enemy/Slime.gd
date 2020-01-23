extends KinematicBody2D

const GRAVITY = 35

export var horizontal_speed = 250 # if negative, it will start moving right

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
		
		horizontal_speed *= -1
	
	$Sprite.set_flip_h(horizontal_speed > 0)
	pass