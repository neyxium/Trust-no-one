extends Control

@onready var dialogue_label: RichTextLabel = %Dialogue
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	var current_call = EmergencyCall.generate_random_call()
	Show_call(current_call)

func Show_call(call: EmergencyCall) -> void:
	for num in range(call.dialogue_list.size()):
		dialogue_label.visible_characters = 0
		dialogue_label.text = call.get_formatted_dialogue(num)
		
		while dialogue_label.visible_characters < dialogue_label.text.length():
			dialogue_label.visible_characters += 1
			for i in range(4):
				await get_tree().process_frame
		
		await get_tree().create_timer(2).timeout
