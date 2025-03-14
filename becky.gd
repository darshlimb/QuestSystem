extends Interactable


func on_interacted()-> void:
	var quest: Quest = quest_manager.get_active_quest_by_id("1")
	if quest:

		quest.update_quest_completion()
		var result = quest.is_completed()
		
		if result:
			var items_to_give: Array[String] = ["Apple","Banana"]
			World.player_inventory.erase(items_to_give)
			quest.on_quest_completed()
			quest_manager.complete_quest(quest)
	
