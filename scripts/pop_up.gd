extends Label3D

@export var t = ""
@export var color = Color.WHITE

func _ready() -> void:
	text = t
	modulate = color
	var tween = create_tween()
	tween.tween_property(self,"global_position",global_position + Vector3(0,2,0),.9)


func _on_timer_timeout() -> void:
	queue_free()
