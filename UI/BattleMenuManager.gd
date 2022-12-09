extends Control

onready var battle_menu: HBoxContainer = $"%BattleMenu"
onready var action_list: PanelContainer = $"%ActionList"
onready var item_list: PanelContainer = $"%ItemList"

func _ready() -> void:
	battle_menu.show_menu()
