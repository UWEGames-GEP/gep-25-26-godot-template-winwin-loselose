extends Node

@onready var gamemanager
@onready var pause_menu
@onready var enums

func _ready() -> void:
	gamemanager = get_tree().get_first_node_in_group("game_manager")
	pause_menu = get_tree().get_first_node_in_group("p_menu")
	enums = gamemanager.GameStates
	
func _physics_process(delta: float) -> void:
	if gamemanager.state == gamemanager.GameStates.PAUSED:
		pause_menu.visible = true
	else:
		pause_menu.visible = false

func _on_quit_btn_pressed() -> void:
	get_tree().queue_free()

func _on_options_btn_pressed() -> void:
	pass # Replace with function body

func _on_play_btn_pressed() -> void:
	gamemanager.state = enums.GAMEPLAY
	gamemanager.stateChanged()
