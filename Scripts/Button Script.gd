extends StaticBody2D

export(int,"Red","Green") var type = 0;
export(bool) var active: bool = false;
onready var image: AnimatedSprite = $Sprite;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _toggle(body):
	
	if body is PlayerChar || body is Box:
	
		image.animation = "On" if !active else "Off";
		$"Button Collider".position.y = 3 if !active else -1;
		active = !active;
	
	pass

func _green_toggle(body):
	if ( body is PlayerChar || body is Box ) && type == 1:
	
		image.animation = "On" if !active else "Off";
		$"Button Collider".position.y = 3 if !active else -1;
		active = !active;
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
