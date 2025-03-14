extends QuestCondition
class_name ConditionLocation

@export var entity_name: String = ""
@export var location: String = ""

func get_entity_location(_name: String)-> String:
	# this should suffice for now
	return World.player_location

func assert_completion()-> bool:
	var self_loc = get_entity_location(entity_name)
	if location == World.player_location:
		return true
	
	return false

func fail_condition()-> void:
	condition_achievable = false
