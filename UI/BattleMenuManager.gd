extends Control

var elizabethStats : PlayerClassStats = ReferenceStash.elizabethStats

var uiStack := UIStack.new()

onready var battle_menu: HBoxContainer = $"%BattleMenu"
onready var action_list: PanelContainer = $"%ActionList"
onready var item_list: PanelContainer = $"%ItemList"

func _ready() -> void:
	action_list.fill(elizabethStats.battle_actions)
	item_list.fill(elizabethStats.inventory.items)
	yield(battle_menu.show_menu(), "completed")
	uiStack.push(battle_menu)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		uiStack.pop()


func _on_BattleMenu_menu_option_selected(option : int) -> void:
	match option:
		BattleMenu.ACTION: # could also use battle_menu.ACTION
			uiStack.push(action_list)
		BattleMenu.ITEM:
			uiStack.push(item_list)


func _on_ActionList_resource_selected(resource : BattleAction) -> void:
	print(resource.name)


func _on_ItemList_resource_selected(resource : Item) -> void:
	print(resource.name)
