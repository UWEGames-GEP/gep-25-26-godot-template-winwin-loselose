extends Node3D

@onready var game_manager
@onready var inventory_parent
@onready var sylladex_item
var items: Array #nodes
var inventory_slots: Array #nodes
var slots_children: Array #nodes
var can_add_item = false
var to_destroy #node
var visual_timer = 1.6
@onready var pickup_sfx
@onready var drop_sfx
var newPosition
var newRotation
func _ready() -> void:
	game_manager = get_tree().get_first_node_in_group("game_manager")
	inventory_parent = get_tree().get_first_node_in_group("inventory")
	for i in inventory_parent.get_child_count():
		inventory_slots.push_front(inventory_parent.get_child().get_node())
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
	elif game_manager.state != game_manager.GameStates.INVENTORY:
		inventory_parent.visible = false
		can_add_item = true
	
	if Input.is_action_pressed("drop"):
		#removeItems() push it into the different script
		pass

func addItem(itemObj: Node3D, item_name: String):
	if can_add_item:
		if items.size() < 6:
			itemObj.visible = false
			#pickup_sfx.play
			visual_timer = 1.6
			items.append(itemObj)
			for i in items.size():
				if inventory_slots.get(i).get_node().get_child_count():
					inventory_slots.get(i).add_child(sylladex_item)
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
func spawnInfrontOfPlayer():
	var currentWorldPosition = self.global_position
	var forward = Vector3.FORWARD
	var rng = RandomNumberGenerator.new()
	var randomization = Vector3(rng.randf_range(0, 0.5), rng.randf_range(0, 0.5), rng.randf_range(0, 0.5))
	var newPosition = (currentWorldPosition + randomization) + forward
	var currentRotation = self.rotation
	var newRotation = currentRotation * Vector3(0,0,180)
	newPosition += Vector3(0,0.5,0)

func removeItem():
	if can_add_item:
		for i in items.size():
			#play drop sfx
			if items.find(i) != null:
				items.find(i) == null
				
			#items.find(i).get_node().visible = false NOT WORKING
			items.get(i).get_node().position = newPosition
			items.get(i).rotation = newRotation
			items.remove_at(i)
			break
		for i in slots_children.size():
			slots_children.get(i).queue_free()
			slots_children.remove_at(i)
	items.sort()

func removeSelectedItem(itemToRemove: int):
	spawnInfrontOfPlayer()
	#play drop sfx
	if items.get(itemToRemove).get_node() != null:
		items.get(itemToRemove).get_node().get_parent() == null
	items.get(itemToRemove).visable = true
	items.get(itemToRemove).global_position = newPosition
	items.get(itemToRemove).rotation = newRotation
	items.remove_at(items.get(itemToRemove))
	slots_children.get(itemToRemove).get_node().queue_free()
	slots_children.remove_at(slots_children.get(itemToRemove))
	items.sort()
