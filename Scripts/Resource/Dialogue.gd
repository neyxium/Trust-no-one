extends Resource
class_name Dialogue

@export var dialogue_sequence : Array[String] = [
	"My name is {caller}!!",
	"I'm currently at {location} and there's an {incident}!!"
]

@export var appearance_weight := 500.0
@export var truth_chance := 50.0
