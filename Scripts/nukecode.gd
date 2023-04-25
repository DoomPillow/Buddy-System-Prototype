extends Node2D

export var index = 0;
export var inverse := false;
onready var _button = get_node("Button");

func _process(delta):
	Global.code_array[index] = int(_button.active) if !inverse else int(!_button.active);
	#print(Global.code_array)
