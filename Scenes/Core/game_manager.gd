extends Control

@onready var dialogue_label: RichTextLabel = %Dialogue
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	var current_call = EmergencyCall.generate_random_call()
	Show_call(current_call)

func Show_call(call: EmergencyCall) -> void:
	dialogue_label.text = call.get_formatted_dialogue()
