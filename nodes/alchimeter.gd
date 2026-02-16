extends Node3D

var game_manager
var base_item = load("res://nodes/item.tscn")
@onready var item_spawn_zone = $"../spawn_zone"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager = get_tree().get_first_node_in_group("game_manager")
	pass # Replace with function body.

func purchase():
	if game_manager != null:
		game_manager.grist -= 10
		var instance = base_item.instantiate()	
		#instance.set_position(self.global_position)
		instance.set_position(item_spawn_zone.global_transform.origin)
		#item_to_remove.reparent()
		get_tree().root.add_child(instance)
		#instance.position = item_spawn_zone.position
		var rng = RandomNumberGenerator.new()
