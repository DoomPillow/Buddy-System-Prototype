extends KinematicBody2D
class_name PlayerChar

onready var hitbox: CollisionShape2D = $hitbox;

### Player Vars

export(String,"SQUARE","CIRCLE") var _PlayerChar = "SQUARE";
var using_ability: bool = false;
var was_using_ability: bool = false;

### Movement Variables
var velocity: Vector2 = Vector2();
var push: Vector2 = Vector2();

var accel: float = 0.2;
var speed: int = 200;

# Jumping variables
var jumph: int = 380;
var coyote: float = 5.0;
var onfloor: bool = true;

var grav: int = 1200;

### Animation Vars

onready var image: AnimatedSprite = $Sprite;
var anim_state : int = 0;


### input
export(String, "wasd","arrows") var ControlScheme = "wasd";

### When Created...
func _ready():
	
	$Ghost.animation = _PlayerChar
	$hitbox.shape = $hitbox.shape.duplicate();
	
	if _PlayerChar == "CIRCLE":
		image.frames = load("res://Sprites/Circle Animations.tres");
		$hitbox.shape.extents.y = 15;
		$hitbox.position.y = -14;
	
	pass

func get_input() -> Array:
	
	# Create local input variables
	var _xinput = int(Input.is_action_pressed("local_right_" + ControlScheme)) - int(Input.is_action_pressed("local_left_" + ControlScheme)) if not (_PlayerChar == "SQUARE" && using_ability) else 0;
	var _yinput = int(Input.is_action_pressed("local_up_" + ControlScheme));
	var _isability = int(Input.is_action_pressed("local_ability_" + ControlScheme));
	
	# Return current input status
	return [_xinput,_yinput,_isability];

func move(xinput,yinput,delta):
	
	## X movement
	
	# Accelerate + Decellerate to target speed
	velocity.x = lerp(velocity.x,xinput*speed,accel);
	
	# If moving, set image flip and animation appropriately
	if xinput != 0:
		
		image.flip_h = false if xinput == 1 else true;
		if anim_state == 0:
			image.animation = "Walking" if onfloor else "Jumping";
		
		pass
	else:
		if anim_state == 0:
			image.animation = "Idle" if onfloor else "Jumping";
	
	if image.animation == "Jumping" && anim_state == 0:
		
		image.frame = 0 if velocity.y < 0 else 1;
		
		pass
	
	## Jumping
	
	if yinput && is_on_floor():
		
		velocity.y -= jumph;
		
		pass
	
	pass

func _physics_process(delta):
	
	# AAAAAAAAAGGGGGGHHHHHH!!!!!
	velocity.y = min(velocity.y,3000)
	if velocity.y > 2900:
		$Meteor.modulate.a = lerp($Meteor.modulate.a, 0.7, 0.1);
	else:
		$Meteor.modulate.a = 0;
	
	if global_position.y > 650:
		if Global.currentlevel == 0:
			global_position.y -= 10000;
		else:
			if $Ghost.ogpos == Vector2(0,0):
				$Ghost.ogpos = global_position;
			$Ghost.active = true;
			$Sprite.visible = false;
			collision_layer = 0;
			collision_mask = 0;
	
	
	
	# Adjust global positions
	if _PlayerChar == "SQUARE":
		Global.playerpos_1 = position;
	else: 
		Global.playerpos_2 = position;
	
	# Check if onfloor using Raycast
	var raycast = get_world_2d().direct_space_state.intersect_ray(global_position,global_position + Vector2(0,10),[self]);
	onfloor = raycast.size() != 0;
	
	## Gather input
	var _input = get_input();
	
	# Use ability with input
	using_ability = _input[2]
	
	# Move with input
	move(_input[0],_input[1],delta);
	
	# Add gravity
	velocity.y += grav * delta if !is_on_floor() else delta * 10;
	# Make it so players cant launch each other out of existence
	velocity.y = max(velocity.y,-jumph);
	# Actually move
	if image.visible:
		velocity = move_and_slide(velocity + push,Vector2.UP);
	
	# Push
	push.x = lerp(push.x,0,0.4);
	push.y = lerp(push.y,0,0.4);
	
	# Clamp position
	global_position.x = clamp(global_position.x,0,980)
	global_position.y = clamp(global_position.y,0,1000)
	
	### ABILITIES	
	if _PlayerChar == "CIRCLE":
		if using_ability:
				
				collision_mask = 1 if collision_mask != 0 else 0;
				if (image.frames) != load("res://Sprites/Circle P Animations.tres"):
					image.frames = load("res://Sprites/Circle P Animations.tres");
				pass 
		else:
			collision_mask = 3 if collision_mask != 0 else 0;
			if (image.frames) != load("res://Sprites/Circle Animations.tres"):
				image.frames = load("res://Sprites/Circle Animations.tres");
		
		pass
	else: ### SQUARE
		
		if using_ability:
			
			was_using_ability = true;
			anim_state = 1 if anim_state == 0 else anim_state;
			
			# Offset
			hitbox.position.x = lerp(hitbox.position.x,1,0.08);
			hitbox.position.y = lerp(hitbox.position.y,-9,0.08);
			# Transform
			hitbox.shape.extents.x = lerp(hitbox.shape.extents.x,19,0.08);
			hitbox.shape.extents.y = lerp(hitbox.shape.extents.y,9,0.08);
			
			pass
		else:
			
			if was_using_ability:
				was_using_ability = false;
				var _anim_complete = anim_state == 2 || (image.frame == 3 && anim_state == 1);
				
				var bounceray = get_world_2d().direct_space_state.intersect_ray(global_position+Vector2(-10,0),global_position + Vector2(10,-50),[self]);
				if bounceray.size() > 0 && _anim_complete:
					anim_state = 3;
					var obj = instance_from_id(bounceray.collider_id);
					if str(obj.get_class()) == "KinematicBody2D":
						obj.push.y -= 2000;
				elif !_anim_complete:
					anim_state = 4;
				elif bounceray.size() <= 0:
					anim_state = 3;

				pass
			
			# Offset
			hitbox.position.x = lerp(hitbox.position.x,1.5,0.3);
			hitbox.position.y = lerp(hitbox.position.y,-19,0.3);
			
			# Transform
			hitbox.shape.extents.x = lerp(hitbox.shape.extents.x,12.5,0.3);
			hitbox.shape.extents.y = lerp(hitbox.shape.extents.y,19,0.3);
			
			pass
	match(anim_state):
		1:
			image.animation = "Bounce down"
			if image.frame == 3:
				anim_state = 2;
			pass
		2:
			image.animation = "Bounce loop"
			pass
		3:
			image.animation = "Bounce up"
			if image.frame == 4:
				anim_state = 0;
		4:
			image.animation = "Bounce down";
			image.frame = (lerp(image.frame, 0, 0.01));
			image.playing = false;
			if image.frame == 0:
				anim_state = 0;
				image.playing = true;
			pass
