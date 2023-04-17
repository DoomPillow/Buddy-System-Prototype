extends Node2D

onready var zone = $Area2D
export var ischest = false;
var transitioning = false;

func _ready():
	pass # Replace with function body.



func _process(delta):
	var overlapping_bodies = zone.get_overlapping_bodies()
	var num_overlapping_bodies = overlapping_bodies.size()

	if num_overlapping_bodies == 2 || Input.is_action_just_pressed("next_level"):
		var player_char_count = 0

		for body in overlapping_bodies:
			if body is PlayerChar:
				player_char_count += 1

		if player_char_count == 2 || Input.is_action_just_pressed("next_level"):
			if ischest:
				transitioning = true;
			else:
				get_tree().change_scene(str("res://Rooms/Level ", Global.currentlevel+1, ".tscn"));
				print("warping to level ", Global.currentlevel+1);
				Global.currentlevel += 1;
	
	# Chest Transition
	if transitioning:
		$CanvasLayer/trans_screen.modulate.a = lerp($CanvasLayer/trans_screen.modulate.a, 1, 0.15);
		if $CanvasLayer/trans_screen.modulate.a >= 0.99:
			get_tree().change_scene(str("res://Rooms/Level ", Global.currentlevel+1, ".tscn"));
			print("warping to level ", Global.currentlevel+1);
			Global.currentlevel += 1;
	pass

