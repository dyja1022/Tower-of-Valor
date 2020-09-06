extends CanvasLayer

onready var lives_lbl : Label = $Lives1
onready var lives_lbl2 : Label = $Lives2

func _on_Player_update_health(health : int):
	lives_lbl.text = "HP: " + str(health)

func _on_Player2_update_health(health : int):
	lives_lbl2.text = "HP: " + str(health)
