extends Node
class_name QuestHolder

# right now I'm thinking of using this quest holder class as a component to be 
# attached to game objects that hold's its specific set of quests so in order
# to split up the quests

@export_multiline var quest_folder: String = "res://quests/"  # Path to quest files
var quests: Array[Quest] = []

func load_quests():
	var dir = DirAccess.open(quest_folder)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"): 
				var quest = load(quest_folder + file_name)
				if quest is Quest:
					quests.append(quest)
			file_name = dir.get_next()
		dir.list_dir_end()
