extends Resource
class_name QuestCondition

@export_multiline var dev_comment: String = ""

var condition_achievable: bool = true

func assert_completion()-> bool:
	push_error("assert_completion() was meant to be overriden not used directly")
	return false

func fail_condition()-> void:
	pass
