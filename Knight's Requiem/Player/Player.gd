extends KinematicBody2D

#signals
signal animate

const GRAVITY = 35
const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)

export var movement_speed = 200
export var jump_force = 700
export var gravity_cap = 90

# node references
onready var animated_sprite : AnimatedSprite = get_node("PlayerAnimation")


var motion = Vector2(0, 0)
var can_jump = false

func _physics_process(delta):
	handle_player_controls()
	pass

func handle_player_controls():
	apply_gravity()
	jump()
	move()
	motion = move_and_slide(motion, UP, false, 48, 0.70, true)
	animate()

func apply_gravity():
	if !is_on_floor():
		motion.y += GRAVITY
		if motion.y >= gravity_cap:
			motion.y = gravity_cap
	else:
		can_jump = true;
	pass

func jump():
	if Input.is_action_just_pressed("jump") and can_jump:
		motion.y -= jump_force
		can_jump = false
	
	if Input.is_action_just_released("jump") and !can_jump and motion.y < 0:
		motion.y = 1
	pass

func move():
	if Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right"):
		motion.x = -movement_speed
	elif Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left"):
		motion.x = movement_speed
	else:
		motion.x = 0
	pass

func animate():
	var has_input = Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")
	emit_signal("animate", motion, is_on_floor(), has_input)
	pass
