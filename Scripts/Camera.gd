extends Camera2D

var origin = position;
onready var menu = $"CanvasLayer/Pause Menu"
onready var filter = $"CanvasLayer/ColorRect"

func _process(delta):
	
	# Easy Pause var
	var _paused = get_tree().paused;
	
	# Move Camera
	if !_paused:
		position = lerp(origin,lerp(Global.playerpos_1,Global.playerpos_2,0.25),0.05);
	
	# Check for pause toggling
	if Input.is_action_just_pressed("ui_cancel"):
		
		get_tree().paused = !get_tree().paused
		menu.visible = !menu.visible
	
	if menu.visible:
		filter.modulate.a = lerp(filter.modulate.a, 1, 0.5)
	else:
		filter.modulate.a = lerp(filter.modulate.a, 0, 0.5)
