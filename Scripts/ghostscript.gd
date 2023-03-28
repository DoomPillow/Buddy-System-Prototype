extends AnimatedSprite

var t = 0;
var active := false

var ogpos = Vector2(0,0)

func _process(delta):
	visible = active
	if !active:
		return
	t += 0.05;
	global_position = Vector2(ogpos.x + 10 * sin(t),ogpos.y -(20*t));
