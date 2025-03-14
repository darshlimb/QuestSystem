extends Area2D
class_name Interactable

@export var quest_manager: QuestManager

func on_interacted() -> void:
	pass

func _on_body_entered(body: PhysicsBody2D)-> void:
	if body is Player:
		body.interactable = self 

func _on_body_exited(body: PhysicsBody2D)-> void:
	if body is Player:
		body.interactable = null
