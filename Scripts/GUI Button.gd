extends AnimatedSprite

var hovered := false;

func _mouse_enter():
	hovered = true;

func _mouse_exit():
	hovered = false;


func _process(delta):
	
	frame = 1 if hovered && Input.is_action_pressed("ui_accept") else 0;
	scale = Vector2(1.03,1.03) if hovered else Vector2(1,1);
	
	if hovered && Input.is_action_pressed("ui_accept"):
		match(animation):
			"Play":
				pass
			"Options":
				pass
			"Exit":
				get_tree().quit();
