extends Control

var alchemiter
var price_visual
var game_manager
var lack_of_funds
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	alchemiter = get_tree().get_first_node_in_group("alchemiter")
	game_manager = get_tree().get_first_node_in_group("game_manager")
	lack_of_funds = "you need: " + str(10) + "grist"
	price_visual = $price
	pass # Replace with function body.
func _physics_process(delta: float) -> void:
	price_visual.position = get_global_mouse_position()

func _on_katana_pressed() -> void:#
	if game_manager.grist < 10:
		lack_of_funds = "you need: " + str(10) + "grist"
		price_visual.text = lack_of_funds
	else:
		alchemiter.purchase("unbreakable_katana")
	pass # Replace with function body.


func _on_cal_pressed() -> void:
	if game_manager.grist < 20:
		lack_of_funds = "you need: " + str(20) + "grist"
		price_visual.text = lack_of_funds
	else:
		alchemiter.purchase("lil_cal")
	pass # Replace with function body.


func _on_seb_pressed() -> void:
	if game_manager.grist < 30:
		lack_of_funds = "you need: " + str(30) + "grist"
		price_visual.text = lack_of_funds
	else:
		alchemiter.purchase("lil_seb")
	pass # Replace with function body.


func _on_exit_shop_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.queue_free()
	self.visible = false
	pass # Replace with function body.


func _on_katana_mouse_entered() -> void:
	price_visual.text = "purchase unbreakable katana for: " + str(10)
	pass # Replace with function body.


func _on_cal_mouse_entered() -> void:
	price_visual.text = "purchase lil cal for: " + str(20)
	pass # Replace with function body.


func _on_seb_mouse_entered() -> void:
	price_visual.text = "purchase lil seb for: " + str(30)
	pass # Replace with function body.


func _on_katana_mouse_exited() -> void:
	price_visual.text = ""
	pass # Replace with function body.


func _on_cal_mouse_exited() -> void:
	price_visual.text = ""
	pass # Replace with function body.


func _on_seb_mouse_exited() -> void:
	price_visual.text = ""
	pass # Replace with function body.
