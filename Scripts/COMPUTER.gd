extends AnimatedSprite

func _ready():
	pass

func _process(delta):
	match(Global.DETONATE_STATUS):
		0:
			animation = "comp detonate";
		1:
			animation = "comp AAGH";
		-1:
			animation = "comp diffused";
	
	pass
