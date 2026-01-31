@tool
extends Control

const SPRITE_SIZE = Vector2(32,32)

@export var bkg_color : Color
@export var line_color : Color
@export var highlight_color : Color

@export var outer_radius := 256
@export var inner_radius := 64
@export var line_width := 4

@export var options : Array[WheelOption]

var select = 0

func _draw() -> void:
	var offset = SPRITE_SIZE / -2
	
	
	draw_circle(Vector2.ZERO, outer_radius, bkg_color)
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width, true)

	if len(options) >= 3:
		pass
		#draw separator lines
		for i in range(len(options)-1):
			pass
			var rads = TAU * i / (len(options)-1)
			var point = Vector2.from_angle(rads)
			draw_line(
				point * inner_radius, 
				point* outer_radius,
				line_color,
				line_width,
				true
			)
		if options[0].atlas != null:
			draw_texture_rect_region(
				options[0].atlas,
				Rect2(offset, SPRITE_SIZE),
				options[0].region
			)
		
		if select == 0:
			draw_circle(Vector2.ZERO, inner_radius, highlight_color)
		
		for i in range(1, len(options)):
			var start_rads = ((TAU * (i-1)) / (len(options) - 1))
			var end_rads = ((TAU * (i)) / (len(options) - 1))
			var mid_rads = (start_rads + end_rads)/2.0 * -1
			var radius_mid = (inner_radius + outer_radius) / 2
			
			if select == i:
				var points_per_arc = 32
				var points_inner = PackedVector2Array()
				var points_outter = PackedVector2Array()
				
				for j in range(points_per_arc+1):
					pass
					var angle = start_rads + j * (end_rads - start_rads) / points_per_arc
					points_inner.append(inner_radius*Vector2.from_angle(TAU-angle))
					points_outter.append(outer_radius*Vector2.from_angle(TAU-angle))
					
				points_outter.reverse()
				draw_polygon(
					points_inner + points_outter,
					PackedColorArray([highlight_color])
				)
			
			var draw_pos = radius_mid * Vector2.from_angle(mid_rads) + offset
			if options[i].atlas != null:
				draw_texture_rect_region(
					options[i].atlas,
					Rect2(draw_pos, SPRITE_SIZE),
					options[i].region
				)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	var mouse_radius = mouse_pos.length()
	
	if mouse_radius < inner_radius:
		select = 0
	else:
		var mouse_rads = fposmod(mouse_pos.angle() * -1, TAU)
		select = ceil((mouse_rads / TAU) * (len(options)-1))
		
	
	queue_redraw()


func Close():
	pass
	return options[select].name
