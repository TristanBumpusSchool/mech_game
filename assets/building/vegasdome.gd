extends MeshInstance3D

var current_color:="red"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	go_to_red()
	$Timer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print($".".get_surface_material(0).albedo_color)


func go_to_red():
	current_color="red"
	var tween = get_tree().create_tween()
	tween.tween_property($".",$".".get_surface_material(0),Color.RED,1.0)
	#albedo_color=create_tween()
func go_to_green():
	current_color="green"
	
	var tween = get_tree().create_tween()
	tween.tween_property($".",$".".get_surface_material(0),Color.GREEN,1.0)
	#albedo_color=create_tween()
func go_to_blue():
	current_color="blue"
	
	var tween = get_tree().create_tween()
	tween.tween_property($".",$".".get_surface_material(0),Color.BLUE,1.0)
	#albedo_color=create_tween()
func _on_timer_timeout() -> void:
	if current_color=="red":
		go_to_green()
	if current_color=="green":
		go_to_blue()
	if current_color=="blue":
		go_to_red()
	$Timer.start()
