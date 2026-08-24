extends Control

var dragging := false
var tap_position := Vector2.ZERO

func _process(delta: float) -> void:
	if dragging:
		$MapWorld.position = tap_position - get_global_mouse_position()

func _on_map_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		print("pressed")
		dragging = true
		tap_position = get_global_mouse_position()
	else:
		dragging = false
