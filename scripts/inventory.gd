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

func _physics_process(delta: float) -> void:
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
				#UI BULLSHIT
				#inventory_slots[i].gameObject.transform.GetChild(0).gameObject.GetComponent<Animation>().Stop();
				#inventory_slots[i].gameObject.transform.GetChild(0).gameObject.transform.localPosition = new Vector2(0,0);
			pass
	
	if visual_timer > 0 && game_manager.state != game_manager.GameStates.PAUSED:
		inventory_parent.visible = true
		visual_timer -= 1.0 * delta
		
	if visual_timer <= 0:
		inventory_parent.visible = false
	elif game_manager.state != game_manager.GameStates.INVENTORY or game_manager.GameStates.PAUSED && visual_timer < 0:
		inventory_parent.visible = false
		can_add_item = true
	
	if Input.is_action_pressed("drop"):
		removeItem() #push it into the different script
		pass

func addItem(itemObj, item_name: String):
	if can_add_item:
		if items.size() < 6:
			itemObj.visible = false
			#pickup_sfx.play
			visual_timer = 1.6
			items.append(itemObj)
			for i in items.size():
				if inventory_slots.get(i).get_child_count() < 1:
					var instance = sylladex_item.instantiate()
					#instance.set_position(self.global_position)
					inventory_slots.get(i).add_child(instance)
					instance.slot_num = i
					slots_children.append(instance)
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
	var randomization = Vector3(rng.randf_range(0, 0.5), rng.randf_range(0, 0.5), rng.randf_range(0, 0.5))
	newPosition = ($"../Camroot/h/spawn_point".global_position + randomization)

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

func removeSelectedItem(itemToRemove: int):
	#play drop sfx
	print(items.size())
	spawnInFrontOfPlayer()
	
	
	if items.get(itemToRemove) != null:
		items.get(itemToRemove).reparent(get_tree().root)
	
		items.get(itemToRemove).visible = true
		items.get(itemToRemove).freeze = true
		
		items.get(itemToRemove).position = newPosition
		items.get(itemToRemove).rotation = cam_rotation
		
		items.get(itemToRemove).freeze = false
		
		
		items.remove_at(itemToRemove)
		slots_children.get(itemToRemove).queue_free()
		slots_children.remove_at(itemToRemove)
		items.sort()
