extends KinematicBody2D
class_name Box

var velocity = Vector2();
var push = Vector2();
var grv = 1200;

export var pushspeed = 3500;

onready var pushzone = $"Push Zone";

func _process(delta):
	
	push = lerp(push, Vector2(0,0), 0.4);
	
	velocity.y += grv * delta if !is_on_floor() else 0;
	velocity = move_and_slide(velocity + (0.6*push), Vector2.UP);
	
	for body in pushzone.get_overlapping_bodies():
		
		if body is PlayerChar:
			
			if body._PlayerChar == "SQUARE" && body.using_ability:
				position.y -= 5;
			else:
				velocity.x = -pushspeed * sign(body.global_position.x - global_position.x) * delta;
			
		else:
			velocity.x = lerp(velocity.x, 0, 0.2);
		
		pass
	
	pass
