extends Node2D

# Positions
onready var StartPos = $"START POS";
onready var EndPos = $"END POS";
# Platform 
onready var Platform = $"Platform"
# Animation Stuff
onready var Spr_Zipper = $"Zipper";
onready var Spr_Platform = $"Platform/Platform Sprite";
var animspeed = 5;

# Is the platform currently moving?
export(bool) var active: bool = false;
# Should the platform return to starting position if inactive?
export(bool) var pauses: bool = false;

# Other stuff
export(float) var speed: float = 5;
export(bool) var cycle: bool = true;
export(bool) var uses_button: bool = false;


func _ready():
	
	Platform.position = StartPos.position;
	
	pass 


func _process(delta):
	
	if uses_button:
		active = $Button.active;
	
	if active:
		
		if Platform.position.distance_to(EndPos.position) > 1:
			
			Spr_Zipper.playing = true;
			Spr_Platform.playing = true;
			
			Platform.position.x += sign(EndPos.position.x - Platform.position.x) * delta * speed;
			Platform.position.y += sign(EndPos.position.y - Platform.position.y) * delta * speed;
			
		elif cycle:
			
			var _startpos = StartPos.position;
			
			StartPos.position = EndPos.position;
			EndPos.position = _startpos;
		
	else:
		
		Spr_Zipper.playing = false;
		Spr_Platform.playing = false;
		
		if !pauses && Platform.position.distance_to(StartPos.position) > 1:
			
			Platform.position.x += sign(StartPos.position.x - Platform.position.x) * delta * speed;
			Platform.position.y += sign(StartPos.position.y - Platform.position.y) * delta * speed;
		
	
	for body in $Platform/grip.get_overlapping_bodies():
		
		if body is PlayerChar || body is Box:
			
			body.position.x -= sign(StartPos.position.x - Platform.position.x) * delta * speed;
			body.position.y -= sign(StartPos.position.y - Platform.position.y) * delta * speed;
	
	pass
