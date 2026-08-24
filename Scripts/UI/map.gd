extends Control

const SCROLL_SPEED := 0.1

var node_position := Vector2.ZERO

var dragging := false
var scaled_up := false

var tap_position := Vector2.ZERO
var map_position := Vector2.ZERO
var map_scale := 4.0

func _ready() -> void:
	node_position = position
	update_map_size()

func _process(delta: float) -> void:
	if dragging:
		$MapWorld.position = map_position + -(tap_position - get_global_mouse_position())

func _on_button_button_down() -> void:
	dragging = true
	tap_position = get_global_mouse_position()
	map_position = $MapWorld.position

func _on_button_button_up() -> void:
	dragging = false

func _on_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			map_scale = clampf(map_scale + SCROLL_SPEED * map_scale, 4.0, 16.0)
			update_map_size()
		
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			map_scale = clampf(map_scale - SCROLL_SPEED * map_scale, 4.0, 16.0)
			update_map_size()

func update_map_size():
	$MapWorld.scale = Vector2(map_scale, map_scale)

func _on_scale_button_button_down() -> void:
	scaled_up = not scaled_up
	
	if scaled_up:
		size = Vector2(1390, 680)
		position = node_position - Vector2(size.x - 400, 0)
	else:
		size = Vector2(400, 400)
		position = node_position
