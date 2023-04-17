extends StaticBody2D

export(int,"Red","Green") var type = 0;
export(bool) var active: bool = false;
export(bool) var permstate = false;
onready var image: AnimatedSprite = $Sprite;

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group('buttongroup')
	pass

func _toggle(body):
	
	if body is PlayerChar || body is Box:
		
		if permstate == false || (permstate == true && active == false):
			image.animation = "On" if !active else "Off";
			$"Button Collider".position.y = 3 if !active else -1;
		active = !active if permstate == false else true;
		
	
	pass

func _green_toggle(body):
	if ( body is PlayerChar || body is Box ) && type == 1:
	
		image.animation = "On" if !active else "Off";
		$"Button Collider".position.y = 3 if !active else -1;
		$"Button Collider".one_way_collision = false;
		active = !active;
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
