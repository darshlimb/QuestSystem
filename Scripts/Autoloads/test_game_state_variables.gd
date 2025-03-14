extends Node
# Think of this script as the player, enemy or other relevant game object in the world

# I didn't use signals for now
signal EnemyKilled
signal ItemHarvested
signal InventoryUpdated

var player_level: int = 0
var player_inventory: Array[String] = [] # Items are just strings for now
var player_location: String = ""

var total_turtle_killed: int = 0
var total_ninja_killed: int = 0

var sunflower_gathered: int = 0
var roses_gathered: int = 0
var total_item_gathered: int = 0

func wait_for_frame()-> void:
	await get_tree().process_frame

func enemy_killed()-> void:
	emit_signal("EnemyKilled")

func item_harvested()-> void:
	emit_signal("ItemHarvested")

var successful: bool = true 
func add_item_to_inventory(item: String)-> void:
	if !successful:
		return
	else:
		emit_signal("InventoryUpdated")
		player_inventory.append(item)
