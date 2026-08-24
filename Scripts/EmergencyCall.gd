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
	GasLeak,
	Medical_Emergency,
	Assault,
	Vandalism,
	SuspiciousActivity,
	SuspiciousPerson,
	MissingPerson
}

@export var call_id: String = "Call_001"

@export_group("Caller info")
@export var caller_name: CallerName
@export var caller_location: LocationName
@export var caller_closest_building: String
@export var caller_incident: IncidentType
@export var caller_tellin_truth: bool

@export_group("Templates")
@export_multiline var text: String = "Hello, I am {caller} and I am at {location}. Here happened {incident}."

func get_formatted_dialogue() -> String:
	var name_str = CallerName.keys()[caller_name].replace("_"," ")
	var location_str = LocationName.keys()[caller_location].replace("_"," ")
	var incident_str = IncidentType.keys()[caller_incident].replace("_"," ")
	var data = {
		"caller": name_str,
		"location": location_str,
		"incident": incident_str
	}
	return text.format(data)
