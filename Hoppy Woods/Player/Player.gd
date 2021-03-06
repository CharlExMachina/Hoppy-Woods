extends KinematicBody2D

signal animate
signal player_hurt
signal stomp_enemy

const UP = Vector2(0, -1)
const GRAVITY = 35
const WORLD_LIMIT = 1900

export var horizontal_speed = 250
export var enemy_bounce_force = 200
export var jump_force = 250 # will be negative when called
export var boost = 400
export var invincible_timer = 2

onready var audio_player : AudioStreamPlayer = get_node("AudioStreamPlayer")
onready var stomp_raycast : RayCast2D = get_node("RayCast2D")

var stomp_sound = preload("res://SFX/SFX_Hurt08.ogg")
var jump_sound = preload("res://SFX/SFX_Jump10.ogg")

var velocity = Vector2(0, 0)
var grounded = false
var snap_vector = Vector2(0, 10)
var is_hurt = false

func _ready():
	set_camera_limits()
	pass

# warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	horizontal_movement()
	jump()
	apply_gravity()
	check_if_stomped_enemy()
	
	snap_vector = Vector2(0, 10) if grounded else Vector2(0, 0)
	velocity = move_and_slide_with_snap(velocity, snap_vector, UP, true, 2)
	if is_on_floor() and (Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right")):
		velocity.y = 0
	
	check_is_on_floor()
	
	if !is_hurt:
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
		audio_player.stream = jump_sound
		audio_player.play()
		velocity.y = -jump_force
		grounded = false
	pass

func apply_gravity():
	velocity.y += GRAVITY
	
	check_is_out_of_bounds()
	pass

func check_is_on_floor():
	if is_on_floor():
		grounded = true
		if is_hurt:
			is_hurt = false
			$RayCast2D.enabled = true
	else:
		grounded = false
	pass

func animate():
	var has_input = Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")
	emit_signal("animate", velocity, grounded, has_input)
	pass

func set_player_invincible():
	#change from player layer to invincible layer
	self.set_collision_layer_bit(4, true)
	self.set_collision_layer_bit(0, false)
	$RayCast2D.enabled = false
	
	#collision with hazards
	self.set_collision_mask_bit(2, false)
	
	set_player_not_invincible(invincible_timer)
	pass

func set_player_not_invincible(seconds):
	yield(get_tree().create_timer(seconds), "timeout")
	stop_invincible_animation()
	
	#change from invincible layer to player layer
	self.set_collision_layer_bit(4, false)
	self.set_collision_layer_bit(0, true)
	
	#collision with hazards enabled again
	self.set_collision_mask_bit(2, true)
	pass

func play_invincible_animation():
	$AnimationPlayer.play("invincible_blink")
	yield(get_tree().create_timer(1), "timeout")
	stop_invincible_animation()
	pass

func respawn():
	play_invincible_animation()
	

func stop_invincible_animation():
	$AnimationPlayer.stop()
	pass

func hurt():
	is_hurt = true
	position.y -= 1
	audio_player.stream = load("res://SFX/SFX_Hit10.ogg")
	audio_player.play()
	grounded = false
	velocity.y = -jump_force
	emit_signal("player_hurt")
	play_invincible_animation()
	set_player_invincible()
	pass

func boost():
	position.y -= 1
	grounded = false
	velocity.y = 0
	velocity.y -= boost
	pass

func check_if_stomped_enemy():
	if stomp_raycast.is_colliding() and not grounded and velocity.y > 0:
		bounce_from_enemy()
		emit_signal("stomp_enemy")

func bounce_from_enemy():
	position.y -= 1
	grounded = false
	velocity.y = 0
	velocity.y -= enemy_bounce_force
	play_stomp_sound()
	pass

func check_is_out_of_bounds():
	if position.y > WORLD_LIMIT:
		# do game over
		get_tree().call_group("Gamestate", "lose_one_up")

func play_stomp_sound():
	audio_player.stream = stomp_sound
	audio_player.play()
	pass

func set_camera_limits():
	var tilemap = get_parent().get_node("CollisionTiles")
	var map_limits = tilemap.get_used_rect()
	var map_cellsize = tilemap.cell_size
	
	if tilemap.scale.x == 2:
		$Camera.limit_left = map_limits.position.x * map_cellsize.x * 2 + 30
		$Camera.limit_right = map_limits.end.x * map_cellsize.x * 2 - 230
		$Camera.limit_top = map_limits.position.y * map_cellsize.y * 2 + 5
		$Camera.limit_bottom = map_limits.end.y * map_cellsize.y * 2
	else:
		$Camera.limit_left = map_limits.position.x * map_cellsize.x + 100
		$Camera.limit_right = map_limits.end.x * map_cellsize.x - 5
		$Camera.limit_top = map_limits.position.y * map_cellsize.y + 5
		$Camera.limit_bottom = map_limits.end.y * map_cellsize.y
