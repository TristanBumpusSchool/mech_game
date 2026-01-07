extends Control

func _ready() -> void:
	$Score.text = "Your final score : " + str(global.score)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE



func _on_reset_pressed() -> void:
	get_tree().change_scene_to_file("res://picking.tscn")
	global.score = 0
