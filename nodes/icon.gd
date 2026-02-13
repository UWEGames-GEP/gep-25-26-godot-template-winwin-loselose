extends Control
var inventory
var game_manager
var slot_num = -1
@onready var anim_player = $AnimationPlayer
func _ready() -> void:
	inventory = get_tree().get_first_node_in_group("inventory")
	game_manager = get_tree().get_first_node_in_group("game_manager")
# Called when the node enters the scene tree for the first time.

func _physics_process(delta: float) -> void:
	for i in inventory.items.size():
		if game_manager.state == game_manager.GameStates.INVENTORY:
			self.get_child(0).position.x = 0
		else:
			self.get_child(0).position.x = -256
func _on_texture_rect_pressed() -> void:
	inventory.removeSelectedItem(inventory.slots_children.find(self))
