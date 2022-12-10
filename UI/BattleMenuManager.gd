extends Control

var elizabethStats : PlayerClassStats = ReferenceStash.elizabethStats

onready var battle_menu: HBoxContainer = $"%BattleMenu"
onready var action_list: PanelContainer = $"%ActionList"
onready var item_list: PanelContainer = $"%ItemList"

func _ready() -> void:
	action_list.fill(elizabethStats.battle_actions)
	item_list.fill(elizabethStats.inventory.items)
	action_list.grab_button_focus()
	yield(battle_menu.show_menu(), "completed")
	battle_menu.grab_action_focus()


func _on_BattleMenu_menu_option_selected(option : int) -> void:
	match option:
		BattleMenu.ACTION: # could also use battle_menu.ACTION
			action_list.show()
			action_list.grab_button_focus()
		BattleMenu.ITEM:
			item_list.show()
			item_list.grab_button_focus()


func _on_ActionList_resource_selected(resource : BattleAction) -> void:
	print(resource.name)


func _on_ItemList_resource_selected(resource : Item) -> void:
	print(resource.name)
