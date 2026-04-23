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
@onready var grist_count = $grist_count
var grist_pickup_timer = 0.0
@onready var grist_bar = $grist_count/TextureRect/TextureProgressBar
@onready var grist_bar_label = $grist_count/TextureRect/value
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

func grist_change_visual():
	grist_bar.value = grist
	grist_bar_label.text = str(grist)
	grist_pickup_timer = 3.0
	
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	inventory_visiblity = get_tree().get_first_node_in_group("inventory")
func _physics_process(delta: float) -> void:
	if state == GameStates.INVENTORY:
		grist_count.position.y = 50
	if grist_pickup_timer > 0:
		grist_pickup_timer -= 1.0 *delta
		if grist_count.position.y <= 50.0:
			grist_count.position.y += 300.0*delta
	else:
		if grist_count.position.y >= -75.0:
			grist_count.position.y -= 200.0*delta
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
	inventory_visiblity.visual_timer = -1
	Engine.time_scale = 1.0
	#get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
func paused():
	inventory_visiblity.visual_timer = 0
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
