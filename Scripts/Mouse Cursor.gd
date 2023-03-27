extends AnimatedSprite

var poswas = Vector2()

func _ready():
	poswas = global_position
	pass # Replace with function body.

func _anim_done():
	animation = "default";

func _process(delta):
	
	# Fade out
	Global.cursortimer -=1;
	if Global.cursortimer <= 0:
		modulate.a = lerp(modulate.a, 0, 0.3)
		scale = lerp(scale, Vector2(0.7,0.7), 0.2)
	else:
		modulate.a = lerp(modulate.a, 1, 0.45)
		scale = lerp(scale, Vector2(1,1), 0.3)
	
	if global_position != poswas:
		print(global_position - poswas)
		poswas = global_position;
		Global.cursortimer = 210;
	
	# Follow mouse
	global_position = get_global_mouse_position() + Vector2(15,15)
	
	# Pretend to work
	#if Input.is_action_just_released("ui_accept"):
	#	frame = 0;
	#	scale = Vector2(0.9,0.9)
	#	animation = "clickclack"
