extends Node

@onready var game_manager
@onready var inventory_parent
var sylladex_item = load("res://nodes/icon.tscn")
var items: Array #nodes
@export var inventory_slots: Array #nodes
@export var slots_children: Array #nodes
@export var can_add_item = true
var to_destroy #node
var visual_timer = 1.6
@onready var pickup_sfx
@onready var drop_sfx
var newPosition
var newRotation
@onready var cam_rotation = $"../Camroot/h".rotation
var selected_card
var is_selected_card_empty: bool = true
@onready var item_holder = $"../Dirk_Strider/item_holder"
var held_item
@onready var raycast = $"../Camroot/h/v/RayCast3D"

func _ready() -> void:
	game_manager = get_tree().get_first_node_in_group("game_manager")
	inventory_parent = get_tree().get_first_node_in_group("inventory_parent")
	for i in inventory_parent.get_child_count():
		inventory_slots.push_front(inventory_parent.get_child(i))
	pass
#[SerializeField] bool can_add_item = false;
#[SerializeField] GameObject inventory_parent;
#[SerializeField] private GameObject sylladex_item;
#public List<GameObject> items = new List<GameObject>();
#public List<GameObject> inventory_slots = new List<GameObject>();
#public List<GameObject> slots_children = new List<GameObject>();

func checker(check_num: int):
	if items.size() < 6:
			#itemObj.visible = false
			$"../pickup_sfx".play() # change to equip sfx
			visual_timer = 1.6
			#items.append(itemObj)
			for i in items.size():
				if inventory_slots.get(i).get_child_count() <= 1:
					items.get(i).reparent(get_tree().get_first_node_in_group("stash"))
					items.get(i).visible = false
					items.get(i).get_child(0).set_monitoring(true)
				if inventory_slots.get(check_num).get_child_count() > 0:
					held_item = items.get(check_num)
					inventory_slots.get(check_num).get_child(0).anim_player.play("sylladex_move")
					held_item.reparent(item_holder)
					held_item.get_child(0).set_monitoring(false)
					held_item.visible = true
					is_selected_card_empty = false
				else:
					is_selected_card_empty = true
	pass
func _input(event: InputEvent) -> void:
	
	#checks input for number on keyboard to match with array for the object to select
	#check if there isnt an item in the slot when dropping, drop top item
	if Input.is_action_just_pressed("1"):
		checker(0)
		if !is_selected_card_empty:
			selected_card = 0
		pass
	if Input.is_action_just_pressed("2"):
		checker(1)
		if !is_selected_card_empty:
			selected_card = 1
		pass
	if Input.is_action_just_pressed("3"):
		checker(2)
		if !is_selected_card_empty:
			selected_card = 2
		pass
	if Input.is_action_just_pressed("4"):
		checker(3)
		if !is_selected_card_empty:
			selected_card = 3
		pass
	if Input.is_action_just_pressed("5"):
		checker(4)
		if !is_selected_card_empty:
			selected_card = 4
		pass
	if Input.is_action_just_pressed("6"):
		checker(5)
		if !is_selected_card_empty:
			selected_card = 5
		pass
	if Input.is_action_pressed("drop"):
		remove_held_item() #push it into the different script
		pass
	if Input.is_action_pressed("interact"):
		if raycast.is_colliding() && raycast.get_collider() != null:
			print(raycast.get_collider())
			if raycast.get_collider().is_in_group("alchemiter"):
				#check if currency is enough
				raycast.get_collider().purchase()
				##open shop ui, for now. spend money spawn item
				
				pass

func _physics_process(delta: float) -> void:
	#check if looking at shop for visual
	if raycast.is_colliding() && raycast.get_collider() != null:
			print(raycast.get_collider())
			if raycast.get_collider().is_in_group("alchemiter"):
				$shop_ui/Label.visible = true
	else:
		$shop_ui/Label.visible = false
	raycast.rotation = $"../Camroot/h/v".global_rotation
	raycast.position = $"../Camroot/h/v".global_position
	if game_manager.state == game_manager.GameStates.PAUSED:
		can_add_item = false
	else:
		can_add_item = true
		
	if game_manager.state == game_manager.GameStates.INVENTORY:
		inventory_parent.visible = true
		for i in items.size():
			pass
			if inventory_slots.size() > 0:
				pass
			pass
	
	if visual_timer > 0 && game_manager.state != game_manager.GameStates.PAUSED:
		inventory_parent.visible = true
		visual_timer -= 1.0 * delta
		
	if game_manager.state != game_manager.GameStates.INVENTORY or game_manager.GameStates.PAUSED:
		if visual_timer < 0:
			inventory_parent.visible = false
		can_add_item = true
	

func addItem(itemObj, item_name: String):
	if can_add_item:
		if items.size() < 6:
			itemObj.visible = false
			$"../pickup_sfx".play()
			visual_timer = 1.6
			items.append(itemObj)
			for i in items.size():
				if inventory_slots.get(i).get_child_count() < 1:
					var instance = sylladex_item.instantiate()
					#instance.set_position(self.global_position)
					inventory_slots.get(i).add_child(instance)
					instance.slot_num = i
					slots_children.append(instance)
					inventory_slots.get(i).get_child(0).anim_player.play("sylladex_move")
					pass
					match (item_name):
						"red_grist": 
							#change colour of grist here
							pass
						"orange_grist":
							#change colour of grist here
							pass
						"green_grist":
							#change colour of girs there
							pass
	pass
	
func spawnInFrontOfPlayer():
	
	var rng = RandomNumberGenerator.new()
	var randomization = Vector3(rng.randf_range(0.1, 0.5), rng.randf_range(0.1, 0.5), rng.randf_range(0.1, 0.5))
	newPosition = ($"../Camroot/h/spawn_point".global_position + randomization)

func remove_held_item():
	spawnInFrontOfPlayer()
	if held_item != null:
		held_item.get_child(0).set_monitoring(true)
	if can_add_item && selected_card != null:
		for i in items.size():
			#play drop sfx
			var item_to_remove
			if items.find(i) != null:
				items.find(i) == null
			item_to_remove = items.get(selected_card)
			items.remove_at(selected_card)
			item_to_remove.visible = true
			item_to_remove.freeze = true
			item_to_remove.rotation = cam_rotation
			item_to_remove.reparent(get_tree().root)
			item_to_remove.position = newPosition
			item_to_remove.freeze = false

			break
		for i in slots_children.size():
			if slots_children.get(selected_card) != null:
				slots_children.get(selected_card).queue_free()
				slots_children.remove_at(selected_card)
		items.sort()
	else:
		removeItem()
	
	
func removeItem():
	spawnInFrontOfPlayer()
	if can_add_item:
		for i in items.size():
			#play drop sfx
			var item_to_remove
			if items.find(i) != null:
				items.find(i) == null
				
			#items.find(i).get_node().visible = false NOT WORKING
			item_to_remove = items.get(i)
			items.remove_at(i)
			item_to_remove.visible = true
			item_to_remove.freeze = true
			item_to_remove.rotation = cam_rotation
			item_to_remove.reparent(get_tree().root)
			item_to_remove.position = newPosition
			item_to_remove.freeze = false

			break
		for i in slots_children.size():
			if slots_children.get(i) != null:
				slots_children.get(i).queue_free()
				slots_children.remove_at(i)
	items.sort()

func removeSelectedUIItem(itemToRemove: int):
	#play drop sfx
	print(items.size())
	spawnInFrontOfPlayer()
	
	
	if items.get(itemToRemove) != null:
		items.get(itemToRemove).reparent(get_tree().root)
	
		items.get(itemToRemove).visible = true
		items.get(itemToRemove).freeze = true
		items.get(itemToRemove).get_child(0).set_monitoring(true)
		items.get(itemToRemove).position = newPosition
		items.get(itemToRemove).rotation = cam_rotation
		
		items.get(itemToRemove).freeze = false
		
		
		items.remove_at(itemToRemove)
		slots_children.get(itemToRemove).queue_free()
		slots_children.remove_at(itemToRemove)
		#items.sort()
