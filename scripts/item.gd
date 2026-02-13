extends Node3D

@onready var inventory
@onready var inventory_parent
@export var obj_name = "default"

func _ready() -> void:
	inventory = get_tree().get_first_node_in_group("inventory")
	inventory_parent = get_tree().get_first_node_in_group("inventory_parent")
	pass

func _physics_process(delta: float) -> void:
	if self.get_parent_node_3d() != null && self.get_parent_node_3d().is_in_group("stash"):
		self.global_position = get_parent_node_3d().global_position.normalized()
		self.freeze = true
	else:
		self.freeze = false
func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if inventory != null && body.is_in_group("player"):
		if inventory.can_add_item:
			inventory.addItem(self, self.get_name())
			inventory_parent.visible = true
			self.visible = false
			self.reparent(get_tree().get_first_node_in_group("stash"))
	pass # Replace with function body.
