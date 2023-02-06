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
var finished_anim := false;

### input
export(String, "wasd","arrows") var ControlScheme = "wasd";

### When Created...
func _ready():
	
	$hitbox.shape = $hitbox.shape.duplicate();
	
	if _PlayerChar == "CIRCLE":
		image.frames = load("res://Sprites/Circle Animations.tres");
		$hitbox.shape.extents.y = 15;
		$hitbox.position.y = -14;
	
	pass

func get_input() -> Array:
	
	# Create local input variables
	var _xinput = int(Input.is_action_pressed("local_right_" + ControlScheme)) - int(Input.is_action_pressed("local_left_" + ControlScheme));
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
		if image.animation != "Bounce down" && image.animation != "Bounce loop":
			image.animation = "Walking" if onfloor else "Jumping";
		
		pass
	else:
		if image.animation != "Bounce down" && image.animation != "Bounce loop":
			image.animation = "Idle" if onfloor else "Jumping";
	
	if image.animation == "Jumping":
		
		image.frame = 0 if velocity.y < 0 else 1;
		
		pass
	
	## Jumping
	
	if yinput && is_on_floor():
		
		velocity.y -= jumph;
		
		pass
	
	pass

func _physics_process(delta):
	
	print(image.frame);
	
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
	velocity = move_and_slide(velocity + push,Vector2.UP);
	
	# Push
	push.x = lerp(push.x,0,0.4);
	push.y = lerp(push.y,0,0.4);
	
	### ABILITIES	
	if _PlayerChar == "CIRCLE":
		if using_ability:
				
				collision_mask = 1;
				
				pass 
		else:
			collision_mask = 3;
		
		pass
	else:
		
		if using_ability:
			
			was_using_ability = true;
			
			# Offset
			hitbox.position.x = lerp(hitbox.position.x,1,0.3);
			hitbox.position.y = lerp(hitbox.position.y,-9,0.3);
			# Transform
			hitbox.shape.extents.x = lerp(hitbox.shape.extents.x,19,0.3);
			hitbox.shape.extents.y = lerp(hitbox.shape.extents.y,9,0.3);
			
			# Animations
			
			image.animation = "Bounce down" if !finished_anim else "Bounce loop";
			
			print(finished_anim);
			if image.animation == "Bounce down" && image.frame == 3:
				finished_anim = true;
			
			pass
		else:
			
			if was_using_ability:
				was_using_ability = false;
				var bounceray = get_world_2d().direct_space_state.intersect_ray(global_position,global_position + Vector2(0,-50),[self]);
				if bounceray.size() > 0:
					var obj = instance_from_id(bounceray.collider_id);
					obj.push.y -= 2000;
					
				# Animations
				image.animation = "Bounce up";
				
				pass
			
			if image.animation == "Bounce up" && image.frame == 4:
				finished_anim = false;
			
			# Offset
			hitbox.position.x = lerp(hitbox.position.x,1.5,0.6);
			hitbox.position.y = lerp(hitbox.position.y,-19,0.6);
			
			# Transform
			hitbox.shape.extents.x = lerp(hitbox.shape.extents.x,12.5,0.6);
			hitbox.shape.extents.y = lerp(hitbox.shape.extents.y,19,0.6);
			
			pass
