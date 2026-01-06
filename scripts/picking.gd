extends Control


var discription = ["High damage, low fire rate", "High fire rate, low damage", "Everything down the middle","A melee option dealing large amounts of damage"]


func change():
	$left_label.text = discription[global.left]
	$right_label.text = discription[global.right]
	
	$"3d_stuff/joint2/placement".get_child(0).queue_free()
	$"3d_stuff/joint/placement".get_child(-0).queue_free()
	
	var l = load(global.arms[global.left]).instantiate()
	var r = load(global.arms[global.right]).instantiate()
	l.type = 3
	r.type = 3
	
	$"3d_stuff/joint2/placement".add_child(l)
	$"3d_stuff/joint/placement".add_child(r)



func _ready():
	change()



func _on_left_pressed() -> void:
	global.left += 1
	if global.left == discription.size():
		global.left = 0
	change()


func _on_right_pressed() -> void:
	global.right += 1
	if global.right == discription.size():
		global.right = 0
	change()


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_design_01.tscn")
