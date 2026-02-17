extends Node3D

var game_manager
#var default_item = load("res://nodes/item.tscn")
var unbreakable_katana = load("res://nodes/unbreakable_katana.tscn")
var lil_cal = load("res://nodes/lil_cal.tscn")
var lil_seb = load("res://nodes/lil_seb.tscn")
@onready var player
var shop_ui_obj = load("res://nodes/shop_ui.tscn")
var shop_ui
@onready var item_spawn_zone = $"../spawn_zone"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	shop_ui = get_tree().get_first_node_in_group("shop_ui")
	game_manager = get_tree().get_first_node_in_group("game_manager")
	pass # Replace with function body.
func view_shop():
	var instance = shop_ui_obj.instantiate()	
	add_child(instance)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass
	
func purchase(item: String):
	var instance
	if game_manager != null:
		match (item):
			"unbreakable_katana":
				instance = unbreakable_katana.instantiate()
				game_manager.grist -= 10
				pass
			"lil_cal":
				instance = lil_cal.instantiate()
				game_manager.grist -= 20
				pass
			"lil_seb":	
				instance = lil_seb.instantiate()
				game_manager.grist -= 30
				pass
			pass
		instance.type(item)
		
		
		#instance.set_position(self.global_position)
		instance.set_position(item_spawn_zone.global_transform.origin)
		#item_to_remove.reparent()
		get_tree().root.add_child(instance)
		#instance.position = item_spawn_zone.position
		var rng = RandomNumberGenerator.new()
