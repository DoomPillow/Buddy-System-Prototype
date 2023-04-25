extends Line2D

export var length = 2
var point = Vector2()

func _process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0

	point = get_parent().global_position

	# Check if player goes offscreen through the bottom
	if point.y > 650:
		
		# Adjust the position of each point in the trail
		for i in range(get_point_count()):
			set_point_position(i, get_point_position(i) + Vector2(0,-10000))

	add_point(point)

	while get_point_count() > length:
		remove_point(0)
