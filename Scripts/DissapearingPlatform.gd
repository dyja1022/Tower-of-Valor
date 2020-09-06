extends StaticBody2D

onready var fadeout_timer = $FadeOut
onready var fadein_timer = $FadeIn
onready var collider = $CollisionShape2D
onready var area_collider = $Area2D/CollisionShape2D

func _on_Area2D_body_entered(body):
	if fadeout_timer.time_left > 0:
		return
	fadeout_timer.start()

func _on_FadeOut_timeout():
	fadeout_timer.stop()
	fadein_timer.start()
	hide()
	collider.disabled = true
	area_collider.disabled = true
	
func _on_FadeIn_timeout():
	fadein_timer.stop()
	show()
	collider.disabled = false
	area_collider.disabled = false
