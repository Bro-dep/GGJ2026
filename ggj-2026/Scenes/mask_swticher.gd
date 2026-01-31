@tool
extends Control


@export var bkg_color : Color
@export var line_color : Color

@export var outer_radius := 256
@export var inner_radius := 64
@export var line_width := 4


func _draw() -> void:
	draw_circle(Vector2.ZERO, outer_radius, bkg_color)
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
