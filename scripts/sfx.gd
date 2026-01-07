extends AudioStreamPlayer3D


@export var sound = ""



func _ready() -> void:
	stream = load(sound)
	pitch_scale = randf_range(.8,1.2)


func _on_finished() -> void:
	queue_free()
