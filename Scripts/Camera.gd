extends Camera2D

var origin = position;

func _process(delta):
	
	position = lerp(origin,lerp(Global.playerpos_1,Global.playerpos_2,0.5),0.1);
	
	
