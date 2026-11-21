extends Camera2D

@export var player: CharacterBody2D
@export var boundary: Polygon2D

@export var follow_speed: float = 5.0

var search_iterations = 16

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if player == null or boundary == null:
		return
		
	var desired = global_position.lerp( player.global_position, 1.0 - exp(-follow_speed * delta))
	
	var new_x = move_axis(global_position, desired.x, true)
	
	global_position.x = new_x
	
	var new_y = move_axis(global_position, desired.y, false)
	
	global_position.y = new_y
	
func move_axis(start: Vector2, target: float, horizontal: bool) -> float:
	
	var destination = start
	
	if horizontal:
		destination.x = target
	else:
		destination.y = target
		
		
	if camera_fits(destination):
		return target
		
		
	var low = 0.0
	var high = 1.0
	
	for i in range(search_iterations):
		
		var mid = (low + high) / 2.0
		var test_position = start.lerp(destination, mid)
		
		if camera_fits(test_position):
			low = mid
		else:
			high = mid
			
	var result = start.lerp(destination, low)
	
	if horizontal:
		return result.x
	else:
		return result.y
		
func camera_fits(camera_position: Vector2) -> bool:
	

	var half_size = get_viewport_rect().size / zoom / 2.0
	
	var left = camera_position.x - half_size.x
	var right = camera_position.x + half_size.x
	var top = camera_position.y - half_size.y
	var bottom = camera_position.y + half_size.y
	
	var corners = [Vector2(left, top), Vector2(right, top), Vector2(right, bottom), Vector2(left, bottom)]
	
	var polygon_points = PackedVector2Array()
	
	for point in boundary.polygon:
		polygon_points.append(boundary.to_global(point))
		
	for corner in corners:
		if not Geometry2D.is_point_in_polygon(corner, polygon_points):
			return false
			
	for i in range(polygon_points.size()):
		
		var a = polygon_points[i]
		var b = polygon_points[(i + 1) % polygon_points.size()]
		
		for j in range(4):
			
			var c = corners[j]
			var d = corners[(j + 1) % 4]
			
			var intersection = Geometry2D.segment_intersects_segment( a, b, c, d )
			
			if intersection != null:
				return false
				
	for point in polygon_points:
		
		if point.x > left and point.x < right:
			if point.y > top and point.y < bottom:
				return false
				
	return true
