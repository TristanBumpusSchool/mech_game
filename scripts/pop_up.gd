extends Label3D

@export var t = ""
@export var color = Color.WHITE

func _ready() -> void:
	text = t
	modulate = color
	print("s")


func _on_timer_timeout() -> void:
	queue_free()
