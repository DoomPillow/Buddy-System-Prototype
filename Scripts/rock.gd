extends KinematicBody2D

var velocity = Vector2();
export var grv = 10;
export var hgrv = 0;

var push = Vector2(0,0);

func _ready():
	pass

func _process(delta):
	
	if global_position.y > 650:
		global_position.y -= 1000;
	
	velocity.y += grv;
	if hgrv == 0:
		velocity.x = 0;
	else:
		velocity.x += hgrv;
	
	velocity = move_and_slide(velocity, Vector2.UP);
	
	if hgrv == 0:
		$killzone/box.position.y = 15 + (velocity.y * 0.05);
	else:
		$killzone/box.position.x = 15 + (velocity.y * 0.05);
	
	for body in $killzone.get_overlapping_bodies():
		if body is PlayerChar:
			if body.get_node("Ghost").ogpos == Vector2(0,0):
				body.get_node("Ghost").ogpos = body.global_position
			body.get_node("Ghost").active = true;
			body.get_node("Sprite").visible = false;
			body.collision_layer = 0;
			body.collision_mask = 0;
			Global.CroakkumSalad = true;
	# && ((abs(velocity.y) > 1 && grv != 0) || (abs(velocity.x) > abs(hgrv) && hgrv != 0))
	
	pass
