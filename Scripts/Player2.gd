extends KinematicBody2D

signal update_health
signal zero_health

export var speed = 50
export var jump_speed = -125
export var jump_damage = 2
export var gravity = 400
export var health = 3

export  var friction = 0.2
export  var acceleration = 0.25

export var can_take_dmg = true
onready var invulnerable_timer = $Invulnerable
onready var feet = $FeetArea

var velocity = Vector2.ZERO

var is_on_moving_plat = false
var moving_plat_vel = Vector2.ZERO

func get_input():
	var dir = 0
	if Input.is_action_pressed("move_right_2"):
		dir += 1
	if Input.is_action_pressed("move_left_2"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
				
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump_2"):
		if is_on_floor() || is_on_moving_plat:
			velocity.y = jump_speed
	if velocity.y < 0 and Input.is_action_just_released("jump_2"):
		velocity.y = 0
	
	velocity = move_and_slide(velocity, Vector2.UP)
		
func take_damage(damage : int, push_dir : Vector2 = Vector2.ZERO, push_force : float = 100):
	if can_take_dmg:
		if push_dir != Vector2.ZERO:
			velocity = push_dir * push_force
		health -= damage
		can_take_dmg = false
		flash_colors()
		invulnerable_timer.start()
		set_collision_layer_bit(0, false)
		emit_signal("update_health", health)
		if (health <= 0):
			emit_signal("zero_health")
			queue_free()

func flash_colors():
	while !can_take_dmg:
		sprite_white()
		yield(get_tree().create_timer(.1), "timeout")
		sprite_default()
		yield(get_tree().create_timer(.1), "timeout")


	
func sprite_default():
	modulate = Color(1, 1, 1) # blue shade

func sprite_white():
	modulate.r = 10
	modulate.g = 10
	modulate.b = 10
	modulate.a = .5
	
		
func _on_Invulnerable_timeout():
	can_take_dmg = true
	invulnerable_timer.stop()
	set_collision_layer_bit(0, true)
	
	
func _on_FeetArea_body_entered(body):
	if body.is_in_group("enemy"):
		if "Bat" in body.name:
			velocity.y = jump_speed
		body.take_damage(jump_damage)
	if "MovingPlatform" in body.name:
		is_on_moving_plat = true
		
func _on_FeetArea_body_exited(body):
	if "MovingPlatform" in body.name:
		is_on_moving_plat = false
