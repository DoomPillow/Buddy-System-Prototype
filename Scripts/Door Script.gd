extends Node2D

onready var sprite = $Sprite;
onready var hitbox = $CollisionBox;
export var nukedoor = false;

export(bool) var inverse = false;
var open: bool = false;
export(bool) var uses_button: bool = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	
	if !nukedoor:
		sprite.animation = "Open" if open else "Closed";
		hitbox.disabled = true if open else false;
		
		if uses_button:
			var _button = get_node("Button") if get_node("Button") != null else get_node("rock/Button") ;
			open = _button.active if !inverse else !_button.active;
	else:
		var correct = true;
		for digit in Global.code_array:
			print(digit);
			if digit == 0:
				correct = false;
		open = correct;
		sprite.animation = "Open" if open else "Closed";
		hitbox.disabled = true if open else false;
		$sign.animation = "Sign GRANTED" if open else "Sign DENIED";
	
	pass
