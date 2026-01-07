extends CanvasLayer

var open = false


func _ready() -> void:
	$Control/sfx_button.text = "SFX : " + str(global.sfx_vol)
	$Control/music_button.text = "Music : " + str(global.music_vol)
	open = true
	open = false


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


func _on_sfx_button_pressed() -> void:
	global.sfx_vol += 1
	if global.sfx_vol > 10:
		global.sfx_vol = 0
	$Control/sfx_button.text = "SFX : " + str(global.sfx_vol)
	var sfx_bus = AudioServer.get_bus_index("sfx")
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(global.sfx_vol))


func _on_music_button_pressed() -> void:
	global.music_vol += 1
	if global.music_vol > 10:
		global.music_vol = 0
	$Control/music_button.text = "Music : " + str(global.music_vol)
	var music_bus = AudioServer.get_bus_index("music")
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(global.music_vol))
