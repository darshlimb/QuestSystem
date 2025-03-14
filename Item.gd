extends Area2D
class_name Item

@onready var label = $ColorRect/Label

@export var item_name: String = ""

func _ready()-> void:
	label.text = item_name
	deactivate()

func deactivate()-> void:
	#label.text = ""
	self.visible = false
	
	
func activate()-> void:
	self.visible = true


func _on_body_entered(body: PhysicsBody2D):
	if body is Player:
		if item_name:
			World.player_inventory.append(self.item_name)
			print(World.player_inventory)
			queue_free()
