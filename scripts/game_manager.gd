extends Node3D

@onready var player
#grab player inputs to pause them 
enum GameStates {GAMEPLAY, PAUSED, INVENTORY}
var state: GameStates

var state_changing = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	stateManager()

func stateManager():
#checks for player input, changes the state and then runs a bool to ensure the statechange doesnt loop
	if Input.is_action_pressed("pause"):
		state = GameStates.PAUSED
		stateChanged()
		
	if Input.is_action_pressed("return"):
		state = GameStates.GAMEPLAY
		stateChanged()
		
	if Input.is_action_pressed("inventory"):
		state = GameStates.INVENTORY
		stateChanged()
		
func stateChanged():
	match state:
		GameStates.GAMEPLAY:
			gameplay()
			pass
		GameStates.PAUSED:
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
	#empty lol
	pass
