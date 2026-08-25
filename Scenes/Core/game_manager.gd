extends Control

@onready var dialogue_label: RichTextLabel = %Dialogue
@onready var send_button: Button = %SendUnitsButton
@onready var finish_button: Button = %FinishCallButton

var current_call: EmergencyCall
var available_units: int = 3

var call_running := false

var successful_responses: int = 0
var wasted_units: int = 0
var unanswered_crises: int = 0

func _ready() -> void:
	randomize()
	
	send_button.pressed.connect(_on_send_units_pressed)
	finish_button.pressed.connect(_on_finish_call_pressed)

	start_new_call()

func show_call(call: EmergencyCall) -> void:
	for num in range(call.dialogue_list.size()):
		if not call_running: # if call ended before finishing
			return
		
		dialogue_label.visible_characters = 0
		dialogue_label.text = call.get_formatted_dialogue(num)
		
		while dialogue_label.visible_characters < dialogue_label.text.length() and call_running:
			dialogue_label.visible_characters += 1
			for i in range(4):
				if not call_running: # if call ended before finishing
					return
				
				await get_tree().process_frame
		
		for i in range(120): # 2 sec
			if not call_running: # if call ended before finishing
				return
			
			await get_tree().process_frame

func start_new_call() -> void:
	print("Razpoložljive enote: ", available_units)
	
	send_button.disabled = (available_units <= 0)
	current_call = EmergencyCall.generate_random_call()
	
	await get_tree().create_timer(1).timeout
	
	call_running = true
	show_call(current_call)

func _on_send_units_pressed() -> void:
	if available_units > 0:
		available_units -= 1
		
		if current_call.caller_tellin_truth:
			successful_responses += 1
		else:
			wasted_units += 1
		
		call_running = false
		dialogue_label.visible_characters = 0
		
		start_new_call()

func _on_finish_call_pressed() -> void:
	if current_call.caller_tellin_truth:
		unanswered_crises += 1
	else:
		successful_responses += 1
	
	call_running = false
	dialogue_label.visible_characters = 0
	
	start_new_call()
