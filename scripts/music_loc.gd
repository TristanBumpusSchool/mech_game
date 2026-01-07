extends AudioStreamPlayer


func _ready() -> void:
	play(global.menu_music_location)

func _process(delta: float) -> void:
	global.menu_music_location = get_playback_position()
