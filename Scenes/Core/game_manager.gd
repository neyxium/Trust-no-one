extends Control

@onready var dialogue_label: RichTextLabel = %Dialogue
@onready var send_button: Button = %SendUnitsButton
@onready var finish_button: Button = %FinishCallButton

var current_call: EmergencyCall
var available_units: int = 3

var successful_responses: int = 0
var wasted_units: int = 0
var unanswered_crises: int = 0

func _ready() -> void:
	randomize()
	
	send_button.pressed.connect(_on_send_units_pressed)
	finish_button.pressed.connect(_on_finish_call_pressed)

	start_new_call()

func start_new_call() -> void:
	current_call = EmergencyCall.generate_random_call()
	dialogue_label.text = current_call.get_formatted_dialogue(0)
	
	send_button.disabled = (available_units <= 0)
	
	print("Razpoložljive enote: ", available_units)

func _on_send_units_pressed() -> void:
	if available_units > 0:
		available_units -= 1
		
		if current_call.caller_tellin_truth:
			successful_responses += 1
		else:
			wasted_units += 1
		
		start_new_call()
		
func _on_finish_call_pressed() -> void:
	if current_call.caller_tellin_truth:
		unanswered_crises += 1
	else:
		successful_responses += 1
		
	start_new_call()
