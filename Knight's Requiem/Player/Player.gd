extends KinematicBody2D

signal animate

const UP = Vector2(0, -1)
const GRAVITY = 35

var horizontal_speed = 250
export var jump_force = 250 # will be negative when called

var velocity = Vector2(0, 0)
var grounded = false;
var snap_vector = Vector2(0, 32)

# warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	horizontal_movement()
	jump()
	apply_gravity()
	
	snap_vector = Vector2(0, 32) if grounded else Vector2(0, 0)
	velocity = move_and_slide_with_snap(velocity, snap_vector, UP, true, 2)
	if is_on_floor() and (Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right")):
		velocity.y = 0
	
	check_is_on_floor()
	animate()
	pass

func horizontal_movement():
	if Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right"):
		velocity.x = -horizontal_speed
	elif Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left"):
		velocity.x = horizontal_speed
	else:
		velocity.x = 0
	pass

func jump():
	if Input.is_action_just_pressed("jump") and grounded:
		velocity.y = -jump_force
		grounded = false
	pass

func apply_gravity():
	velocity.y += GRAVITY
	pass

func check_is_on_floor():
	if is_on_floor():
		grounded = true;
	else:
		grounded = false;
	pass

func animate():
	var has_input = Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")
	emit_signal("animate", velocity, grounded, has_input)
	pass