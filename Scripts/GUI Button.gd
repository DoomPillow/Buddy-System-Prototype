extends AnimatedSprite

var hovered := false;

func _process(delta):
	
	var mousepos = get_global_mouse_position()
	hovered = abs(global_position.x - mousepos.x) < 100 && abs(global_position.y - mousepos.y) < 40
	
	frame = 1 if hovered && Input.is_action_pressed("ui_accept") else 0;
	scale = Vector2(1.03,1.03) if hovered else Vector2(1,1);
	
	if hovered && Input.is_action_just_released("ui_accept"):
		match(animation):
			"Play":
				pass
			"Options":
				pass
			"Exit":
				get_tree().quit();
