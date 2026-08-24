extends Control

@export var current_call: EmergencyCall

@onready var dialogue_label: RichTextLabel = %Dialogue
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if current_call != null:
		Show_call(current_call)
	else:
		dialogue_label.text = "Waiting for call..."

func Show_call(call: EmergencyCall) -> void:
	dialogue_label.text = call.get_formatted_dialogue()
