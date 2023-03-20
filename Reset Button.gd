extends AnimatedSprite

var hovered := false;


func _process(delta):
	
	hovered =  global_position.distance_to(get_global_mouse_position()) < 80
	
	if hovered && Input.is_action_just_released("ui_accept"):
		get_tree().reload_current_scene()
	
	pass
