extends Node
class_name QuestManager

@export var available_quest_pool: Array[Quest] = []
var active_quests: Array[Quest] = []
var completed_quests: Array[Quest] = []

# for optimization we could use:
# 1) binary search algorithm OR
# 2) hashmaps
func get_available_quest_by_id(id: String)-> Quest:
	for quest: Quest in available_quest_pool:
		if quest.id == id:
			return quest
			
	print("Cannot find available quest")
	return null
	
func get_active_quest_by_id(id: String)-> Quest:
	for quest:Quest in active_quests:
		if quest.id == id:
			return quest
	
	print("Cannot find active quest")
	return null
	
# batch process quest
func check_active_quests_completion(active_quest_array: Array[Quest])-> void:
	var batch_size: int = 5
	var quest_count: int = active_quest_array.size()
	for i: int in range(quest_count):
		var quest: Quest = active_quest_array[i]
		quest.check_if_completed()
		if ((i + 1) % batch_size == 0) or (i == quest_count - 1):
			await get_tree().process_frame

func add_available_quest(quest: Quest) -> void:
	assert(quest not in active_quests and quest not in completed_quests, 
		"Quest '%s' has been already made available before" % quest.title)
	available_quest_pool.append(quest)
	
func start_quest(quest: Quest)-> void:
	assert(quest in available_quest_pool, 
		"Trying to start a quest that shouldn't be available to start yet") # this should never occur though
	# if quest.
	var result: bool = add_to_active(quest)
	if result == true:
		print("New Active Quest successfully added")
		update_quest_text_ui()
func complete_quest(quest: Quest)-> void:
	assert(quest in active_quests, 
		"Trying to complete a quest that is active")
	var result: bool = add_to_completed(quest)
	if result == true:
		update_quest_text_ui()
		
func add_to_active(quest: Quest)-> bool:
	if quest in active_quests:
		return false
	active_quests.append(quest)
	available_quest_pool.erase(quest)
	return true

func add_to_completed(quest: Quest)-> bool:
	if quest in completed_quests:
		return false
	completed_quests.append(quest)
	active_quests.erase(quest)
	return true
	
func try_completing_quest(quest: Quest)-> void:
	var result1 = quest.is_completed()
	if result1:
		add_to_completed(quest)
# --------------------------------------------------------------------------------------
# ui will have its own system this is just placeholder bad code
func update_quest_text_ui()-> void:
	var all_quest_text: Label = $"../Hud/Control/HBoxContainer/VBoxContainer/QuestPanel/Vbox/Control/QuestText"
	var first_quest_text: Label = $"../Hud/Control/HBoxContainer/VBoxContainer/QuestPanel/Vbox/Control2/QuestText"
	var hint_text: Label = $"../Hud/Control/HBoxContainer/VBoxContainer/QuestPanel/Vbox/Control3/QuestText"
	var completed_quest_text: Label = $"../Hud/Control/HBoxContainer/VBoxContainer/QuestPanel/Vbox/Control4/CompletedQuests"

	var quest_titles: Array[String] = []
	var completed_titles: Array[String] = []
	var first_quest: String
	var hint: String
	
	if active_quests:
		first_quest = active_quests[0].title
		hint = active_quests[0].quest_hint
	
	for quest: Quest in active_quests:
		quest_titles.append(quest.title)
	
	for quest: Quest in completed_quests:
		completed_titles.append(quest.title)
		
	all_quest_text.text = "All Quests: " + ", ".join(quest_titles)
	first_quest_text.text = "Current Quest: " + first_quest
	completed_quest_text.text = "Completed Quests: " + ", ".join(completed_titles)
	hint_text.text = hint
