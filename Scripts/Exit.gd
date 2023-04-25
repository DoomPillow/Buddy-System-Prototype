extends Node2D

onready var zone = $Area2D
export var ischest = false;
var transitioning = false;
export var warp := "";
export var floaty := false;
var tsine = 0;


func _ready():
	if warp == "Nuke 1":
		if Global.nuke_unlocked:
			visible = false;
			global_position.y += 999;
		else:
			$AnimatedSprite.animation = "nuke";
			pass
	
	pass



func _process(delta):
	
	# Indicators
	var circle_overlapping = false;
	var rectangle_overlapping = false;
	
	for body in zone.get_overlapping_bodies():
		if body is PlayerChar:
			if body._PlayerChar == "SQUARE":
				rectangle_overlapping = true;
			else:
				circle_overlapping = true;
	
	$"Indicator Circ".frame = int(!circle_overlapping);
	$"Indicator Rect".frame = int(!rectangle_overlapping);
	
	# Map Floaty
	
	if floaty:
		tsine += 0.03;
		global_position.y += 0.3 * cos(tsine);
		global_position.x += 0.3 * sin(tsine);
	
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
				if warp == "":
					get_tree().change_scene(str("res://Rooms/Level ", Global.currentlevel+1, ".tscn"));
					print("warping to level ", Global.currentlevel+1);
					Global.currentlevel += 1;
				else:
					get_tree().change_scene(str("res://Rooms/", warp, ".tscn"));
					print("warping to ", warp);
	
	# Chest Transition
	if transitioning:
		$CanvasLayer/trans_screen.modulate.a = lerp($CanvasLayer/trans_screen.modulate.a, 1, 0.15);
		if $CanvasLayer/trans_screen.modulate.a >= 0.99:
			if warp == "Winscreen 1" && Global.treasure_got == true:
				warp = "Winscreen 2";
			elif warp == "Winscreen 1" && Global.treasure_got == false:
				Global.treasure_got = true;
				
			get_tree().change_scene(str("res://Rooms/", warp, ".tscn"));
			print("warping to level ", warp);
	pass

