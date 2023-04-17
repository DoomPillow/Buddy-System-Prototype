extends AnimatedSprite

func _process(delta):
	
	if Global.CroakkumSalad:
		modulate.a = lerp(modulate.a, 1, 0.1);
		if modulate.a >= 0.99:
			Global.CroakkumSalad = false;
	
