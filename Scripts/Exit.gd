extends Node2D

onready var zone = $Area2D

func _ready():
	pass # Replace with function body.



func _process(delta):
	
	if zone.get_overlapping_bodies().size() == 2:
		#str("Level ", Global.currentlevel + 1)
		get_tree().change_scene(str("res://Rooms/Level ", Global.currentlevel+1, ".tscn"));
		print("warping to level ", Global.currentlevel+1);
		Global.currentlevel += 1;
		
		pass
	
	pass
