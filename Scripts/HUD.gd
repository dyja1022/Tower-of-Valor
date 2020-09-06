extends CanvasLayer

onready var lives_lbl : Label = $Lives1

func _on_Player_update_health(health : int):
	lives_lbl.text = "HP: " + str(health)
