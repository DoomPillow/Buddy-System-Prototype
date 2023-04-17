extends AnimatedSprite

var hovered := false;


func _process(delta):
	
	visible = false if Global.currentlevel == 0 else true;
	hovered =  global_position.distance_to(get_global_mouse_position()) < 80 if visible else false;
	
	if hovered && Input.is_action_just_released("ui_accept"):
		get_tree().reload_current_scene()
	
	pass
