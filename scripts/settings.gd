extends CanvasLayer

var open = false



func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("esc"):
		open = !open
	
	get_tree().paused = open
	
	if open:
		offset.x = 0
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		offset.x = 10000
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_quit_pressed() -> void:
	get_tree().quit()
