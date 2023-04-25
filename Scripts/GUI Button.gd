extends AnimatedSprite

var hovered := false;

func _process(delta):
	
	var mousepos = get_global_mouse_position()
	hovered = abs(global_position.x - mousepos.x) < 100 && abs(global_position.y - mousepos.y) < 40
	
	frame = 1 if hovered && Input.is_action_pressed("ui_accept") else 0;
	scale = Vector2(2.03,2.03) if hovered else Vector2(2,2);
	
	if hovered && Input.is_action_just_released("ui_accept") && get_tree().paused == true:
		match(animation):
			"Play":
				get_tree().paused = !get_tree().paused;
			"Options":
				pass
			"Exit":
				get_tree().change_scene(str("res://Rooms/Title.tscn"));
				Global.currentlevel = -1;
				get_tree().paused = !get_tree().paused;
