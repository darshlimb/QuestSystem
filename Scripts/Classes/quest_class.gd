extends Resource
class_name Quest # can break up this quest class by extending it into smaller parts 
				 # but this should suffice for now
				
enum QuestType{      
	AUTOMATIC,
	CHECKPOINT
}

enum QuestState{     # the conditiontype from the class can handle this itself I believe
	UNACTIVE,
	ACTIVE,
	COMPLETED
}

@export var quest_type: QuestType = QuestType.AUTOMATIC
@export var state: QuestState = QuestState.UNACTIVE
var progress: int = 0

# Base variables
@export var id: String = ""
@export var img_path: String = "" # instead of img being loaded directly it just gives a path which the ui system can use to lazy load
@export var title: String = ""
@export_multiline var description: String = ""
@export_multiline var quest_hint: String = "no hint" # another- quest_img = textureRect

# Conditions are under here
@export_category("Conditions")
@export var start_conditions: Array[QuestCondition] = []
@export var fail_conditions: Array[QuestCondition] = []
@export var completion_conditions: Array[QuestCondition] = []

func can_be_started()-> bool:
	if not start_conditions: # if there are no start conditions, then quest can be activated from anywhere and anytime
		return true
	else:
		# go through all coditions if all of them return true then return true:
		return true
	# if any of the conditions don't return true then returnn false
	return false

func on_quest_started()-> void:
	# QuestDatabase.active_quests.append(self)
	pass

func is_completed()-> bool:
	return true if state == QuestState.COMPLETED else false

func update_quest_completion()-> void: # Batch process 
	if not state == QuestState.ACTIVE: 
		print("Quest ID: " + id + " is being updated for checking completion while being unactive. This shouldn't happen.")
		return
	
	var total_conditions: int = completion_conditions.size()
	
	if total_conditions == 0:
		push_error("No conditions given")
		progress = -100
		return
	
	var completed_count: int = 0
	var batch_size: int = 5
	
	for i: int in range(total_conditions):
		var condition: QuestCondition = completion_conditions[i]
		if condition.assert_completion():
			completed_count += 1
		
		if (i + 1) % batch_size == 0:
			World.wait_for_frame()
			
	progress = (completed_count * 100) / total_conditions
	if progress == 100:
		match quest_type:
			QuestType.AUTOMATIC:
				state = QuestState.COMPLETED
				on_quest_completed()
			QuestType.CHECKPOINT:
				state = QuestState.COMPLETED
				on_quest_completed()
				# for checkpoint based quests, on_quest_completed() is called by a checkpoint
				# the checkpoint being anything we want 
				
func on_quest_completed()-> void:
	print("Quest has been completed")
			
func check_if_appropriate()-> void:
	assert(completion_conditions, "No conditions for completing the quest is given")

# everything below are useless for now
# need to find a good way to create conditions dynamically
func create_conditions()-> void:
	pass
