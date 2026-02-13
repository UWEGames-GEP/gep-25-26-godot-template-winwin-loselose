extends Control
var inventory
var slot_num = -1
@onready var anim_player = $AnimationPlayer
func _ready() -> void:
	inventory = get_tree().get_first_node_in_group("inventory")
# Called when the node enters the scene tree for the first time.

func _on_texture_rect_pressed() -> void:
	inventory.removeSelectedItem(inventory.slots_children.find(self))
