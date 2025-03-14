extends QuestCondition
class_name ConditionItem

@export var entity_inventory: String = ""
@export var item: String = ""

func get_entity_by_name(_name: String)-> Array[String]:
	# this should suffice for now
	return World.player_inventory

func assert_completion()-> bool:
	var self_inventory: Array[String] = get_entity_by_name(entity_inventory)
	if item in self_inventory:
		print("Condition Passed: " + item + " in inventory")
		return true
	
	return false

func fail_condition()-> void:
	condition_achievable = false
