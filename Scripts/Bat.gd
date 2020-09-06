extends "res://Scripts/Enemy.gd"

onready var direction_timer = $SwitchDirectionTimer
onready var attack_area = $AttackArea

export var can_take_dmg = true
onready var invulnerable_timer = $Invulnerable

export var health = 1
export var damage = 1
export var speed = 50

var velocity = Vector2.ZERO
export var dir = -1

func _ready():
	_health = health
	_damage = damage
	_speed = speed

func switch_dir():
	dir *= -1

func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if is_on_wall():
		switch_dir()
	velocity.x = dir
	
	velocity = velocity.normalized() * _speed
	velocity = move_and_slide(velocity)
	
	for i in attack_area.get_overlapping_bodies():
		if i.is_in_group("player"):
			var push_dir = Vector2(i.position.x - position.x, 0).normalized()
			i.take_damage(_damage, push_dir, _damage * 100)
			
func take_damage(damage: int):
	if can_take_dmg:
		_health -= damage
		can_take_dmg = false
		flash_colors()
		invulnerable_timer.start()
		if _health <= 0:
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
