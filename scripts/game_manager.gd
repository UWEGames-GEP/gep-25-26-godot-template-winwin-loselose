extends Node3D

@onready var player
#grab player inputs to pause them 
enum GameStates {GAMEPLAY, PAUSED, INVENTORY}
var inventory_visiblity
var state: GameStates
var grist: int
var state_changing = false
@onready var pickup_sfx = $pickup_sfx
@onready var drop_sfx = $drop_sfx

var menu = load("res://nodes/menu.tscn")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		var instance = menu.instantiate()	
		add_child(instance)
		state = GameStates.PAUSED
		stateChanged()
		
	if Input.is_action_just_pressed("return"):
		state = GameStates.GAMEPLAY
		if get_tree().get_first_node_in_group("shop_ui") != null:
			get_tree().get_first_node_in_group("shop_ui").queue_free()
		if get_tree().get_first_node_in_group("menu") != null:
			get_tree().get_first_node_in_group("menu").queue_free()
		stateChanged()
		
	if Input.is_action_just_pressed("inventory"):
		state = GameStates.INVENTORY
		stateChanged()


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	inventory_visiblity = get_tree().get_first_node_in_group("inventory")

func stateChanged():
	match state:
		GameStates.GAMEPLAY:
			inventory_visiblity.visual_timer = -1
			gameplay()
			pass
		GameStates.PAUSED:
			inventory_visiblity.visual_timer = 0
			paused()
			pass
		GameStates.INVENTORY:
			inventory()
			pass
		
func gameplay():
	Engine.time_scale = 1.0
	#get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
func paused():
	Engine.time_scale = 0.0
	#get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass
func inventory():
	Engine.time_scale = 0.05
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	inventory_visiblity.visual_timer = 1.6

			
	#empty lol
	pass
