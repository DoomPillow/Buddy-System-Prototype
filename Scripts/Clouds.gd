extends Node2D

onready var cloud = preload("res://Objects/Cloud.tscn");

func _ready():
	
	var i = 0;
	while i < 5:
		
		var newcloud = cloud.instance();
		newcloud.position = Vector2(rand_range(-500,900),rand_range(-20,20));
		newcloud.speed = rand_range(40,80);
		newcloud.sinevalue = rand_range(-5,5);
		
		add_child(newcloud);
		
		i += 1;
		
		pass
	
	pass

