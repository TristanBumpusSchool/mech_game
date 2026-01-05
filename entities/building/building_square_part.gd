extends Node3D

@export var hp = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func damaged(d):
	hp -= d
	if hp <= 0:
		$AnimationPlayer.play("explosion")
		$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_timer_timeout() -> void:
	queue_free()
