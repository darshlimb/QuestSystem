extends Interactable

@onready var item_1: Area2D = $"../Item1"
@onready var item_2: Area2D = $"../Item2"
var items: Array[Area2D] = []

func _ready():
	items.append_array([item_1, item_2])  

func on_interacted() -> void:
	print("Interacted with: " + self.name)
	
	var quest: Quest = quest_manager.get_available_quest_by_id("1")
	if quest:
		quest_manager.start_quest(quest)
		
		if items:
			for item in items:
				item.activate()
