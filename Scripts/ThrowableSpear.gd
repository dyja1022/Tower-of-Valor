extends StaticBody2D

onready var stick_timer = $StickTimer

export var spear_damage = 2
export var speed = 125
var has_target = false
var target_pos : Vector2
var target_dir : Vector2

var stick = false

var target_above = false

func _on_BladeArea_body_entered(body):
	if body.has_method("take_damage"):
		if body.is_in_group("player"):
			var push_dir = Vector2(body.position.x - position.x, 0).normalized()
			body.take_damage(spear_damage, push_dir, spear_damage * 100)
	if "Platform" in body.name:
		if "Dissapearing" in body.name:
			return
		stick = true
		stick_timer.start()
		
func _physics_process(delta):
	if stick:
		return
	if has_target:
		global_position += target_dir * speed * delta
		
		rotation_degrees += 10
		
#		if target_above:
#			global_rotation += target_pos.angle_to_point(position) + PI / 2
#		else:
#			global_rotation += target_pos.angle_to_point(position)

func set_target(t : Vector2):
	if t.x > global_position.x:
		scale.x *= -1	
	if t.y < global_position.y:
		target_above = true
	target_pos = t
	target_dir = (target_pos - global_position).normalized()
	has_target = true

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_StickTimer_timeout():
	queue_free()
