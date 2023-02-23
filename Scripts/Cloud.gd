extends AnimatedSprite

var speed = 80;
var sinevalue = 0;

func _ready():
	
	match(round(rand_range(0,2))):
		0.0:
			animation = "big"
		1.0:
			animation = "medium"
		2.0:
			animation = "small"
	
	pass # Replace with function body.

func _process(delta):
	
	position.x -= speed * delta;
	
	sinevalue += delta;
	position.y += 30 * delta * sin(sinevalue);
	
	# Loop around
	if global_position.x < -90:
		
		match(round(rand_range(0,2))):
			0.0:
				animation = "big"
			1.0:
				animation = "medium"
			2.0:
				animation = "small"
		
		speed = rand_range(50,100);
		global_position.x = 2300;
