extends CharacterBody2D
class_name Player

@export var speed: float = 750

var interactable: Interactable = null
@onready var interactable_debug: Label = $Panel/VBoxContainer/Label
@onready var inventory_debug = $Panel/VBoxContainer/Label2

func _physics_process(delta)-> void:

	move()
	interact_feature()
	
	move_and_slide()
	
	# not good, updated every frame for now
	# just for quick implementation since its just the player
	if interactable:
		interactable_debug.text = "Press 'E' to interact"
	else:
		interactable_debug.text = ""
	if World.player_inventory:
		inventory_debug.text = "Inv: " + str(World.player_inventory)
	else:
		"Inv: "

# Player actions
func move()-> void:
	var input_dir: Vector2 = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down")).normalized()
	velocity = (input_dir * speed)
func interact_feature() -> void:
	if Input.is_action_just_pressed("Interact") and interactable:
		interactable.on_interacted()  
