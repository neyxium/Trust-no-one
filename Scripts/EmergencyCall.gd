extends Resource
class_name EmergencyCall

enum CallerName
{
	John_Miller,
	Sarah_Jenkins,
	Robert_Taylor,
	Emily_Davis,
	Michael_Brown,
	Jessica_Wilson,
	David_Anderson,
	Amanda_Thomas,
	James_Jackson,
	Ashley_White,
	
	Dwayne_Johnson,
	Taylor_Swift,
	Peter_Griffin,
	Ron_Swanson,
	Michael_Scott,
	Dwight_Schrute,
	Saul_Goodman,
	Walter_White,
	Guy_Fieri,
	John_Cena
}

enum LocationName{
	#Streets
	Ohio_Avenue,
	Florida_Man_Alley,
	Shrek_Street,
	
	#Destinations
	Krusty_Burger_Parking,
	Area_51_Storage_Unit,
	Goth_Coffee_Shop,
	Basement_Apartment_404,
	Taco_Bell_DriveThru,
}

enum IncidentType
{
	Car_Accident,
	Robbery,
	Burglary,
	Fire,
	Gas_Leak,
	Medical_Emergency,
	Assault,
	Vandalism,
	Suspicious_Activity,
	Suspicious_Person,
	Missing_Person
}

@export var call_id: String = "Call_001"

@export_group("Caller info")
@export var caller_name: CallerName
@export var caller_location: LocationName
@export var caller_closest_building: String
@export var caller_incident: IncidentType
@export var caller_tellin_truth: bool

@export_group("Templates")
@export_multiline var text: String
const DIALOGUE_TEMPLATES: Array[String] = [
	"Oh god, please help me! My name is {caller}. I'm currently at {location} and... oh no, there's an {incident}! Please send someone immediately!",
	"Hi, yes, dispatch? This is {caller}. Listen, I'm standing right outside {location} and a major {incident} just broke out. I think someone is hurt!",
	"Emergency services, please! My name is {caller}, calling from {location}. We have a severe {incident} happening right in front of me. You need to hurry up!",
	"Yeah, hi, um... {caller} here. Look, something weird is going on at {location}. It looks kind of like a {incident} or something? Honestly, I'm not really sure, just maybe send a car?",
	"Hello? Is this the emergency line? My name is {caller} and... look, don't ask questions, but at {location} there's an {incident} and I really need you to clear out. Quickly.",
	"Hey dispatcher, {caller} here. Just letting you know, somebody messed up big time over at {location}. Total {incident}. You guys should probably check that out... or not, whatever.",
	"Ugh, hello? This is {caller}. I was just trying to enjoy my day at {location} and now there's a complete {incident} blocking my way. This is completely unacceptable!",
	"Listen to me very carefully, my name is {caller}. You need to send units to {location} right now because this {incident} is ruining everything. Do you know who I am?!",
	"Uh, hello, 911? {caller} speaking from {location}. So, funny story... a massive {incident} just happened out of nowhere. Can you like, send someone? Thanks."
]

func get_formatted_dialogue() -> String:
	var name_str = get_caller_name()
	var location_str = get_caller_location()
	var incident_str = get_caller_incident()
	var data = {
		"caller": name_str,
		"location": location_str,
		"incident": incident_str
	}
	return text.format(data)
	
func _get_truth_or_lie_value(true_value, all_values: Array, tell_truth: bool):
	if caller_tellin_truth or randf() < 0.5:
		return true_value
	else:
		var choices = all_values.duplicate()
		choices.erase(true_value)
		return choices.pick_random()

func get_caller_name() -> String:
	var choice: CallerName = _get_truth_or_lie_value(caller_name, CallerName.values(), caller_tellin_truth)
	return CallerName.keys()[choice].replace("_"," ")

func get_caller_location() -> String:
	var choice: LocationName = _get_truth_or_lie_value(caller_location, LocationName.values(), caller_tellin_truth)
	return LocationName.keys()[choice].replace("_"," ")
	
func get_caller_incident() -> String:
	var choice: IncidentType = _get_truth_or_lie_value(caller_incident, IncidentType.values(), caller_tellin_truth)
	return IncidentType.keys()[choice].replace("_", " ")
	
static func generate_random_call() -> EmergencyCall:
	var random_call = EmergencyCall.new()
	
	random_call.caller_name = CallerName.values().pick_random() as CallerName
	random_call.caller_location = LocationName.values().pick_random() as LocationName
	random_call.caller_incident = IncidentType.values().pick_random() as IncidentType
	random_call.caller_tellin_truth = randf() < 0.5
	random_call.text = DIALOGUE_TEMPLATES.pick_random()
	
	return random_call
