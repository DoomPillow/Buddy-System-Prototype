extends Node2D

var done := false;
export var warp := "Title"

func _process(delta):
	
	if done:
		$continue.modulate.a = lerp($continue.modulate.a, 1, 0.07);
		
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode != KEY_ENTER:
			if done:
				get_tree().change_scene(str("res://Rooms/", warp ,".tscn"));
				print("warping to asdkspapok");
				if warp == "Title":
					Global.currentlevel = -1;

func _on_Win_Animation_animation_finished(anim_name):
	done = true;
	pass
