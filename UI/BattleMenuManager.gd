extends Control

const RUN_BATTLE_ACTION = preload("res://BattleActions/RunBattleAction.tres")

var elizabethStats : PlayerClassStats = ReferenceStash.elizabethStats
var inventory : Inventory = ReferenceStash.inventory

var uiStack := UIStack.new()

var selected_resource : Resource

onready var battle_menu: HBoxContainer = $"%BattleMenu"
onready var action_list: PanelContainer = $"%ActionList"
onready var item_list: PanelContainer = $"%ItemList"
onready var context_menu: PanelContainer = $"%ContextMenu"
onready var info_menu: PanelContainer = $"%InfoMenu"

signal battle_menu_resource_selected(selected_resource)

func _ready() -> void:
	action_list.fill(elizabethStats.battle_actions)

func show_battle_menu() -> void:
	yield(battle_menu.show_menu(), "completed")
	uiStack.push(battle_menu)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and uiStack.uis.size() > 1:
		uiStack.pop()


func _on_BattleMenu_menu_option_selected(option : int) -> void:
	match option:
		BattleMenu.ACTION: # could also use battle_menu.ACTION
			uiStack.push(action_list)
		BattleMenu.ITEM:
			uiStack.push(item_list)
		BattleMenu.RUN:
			battle_menu.hide_menu()
			battle_menu.release_focus()
			emit_signal("battle_menu_resource_selected", RUN_BATTLE_ACTION)


func _on_ActionList_resource_selected(resource : BattleAction) -> void:
	uiStack.push(context_menu)
	selected_resource = resource

func _on_ItemList_resource_selected(resource : Item) -> void:
	uiStack.push(context_menu)
	selected_resource = resource

func _on_ContextMenu_option_selected(option : int) -> void:
	match option:
		ContextMenu.USE:
			# uiStack.clear()
			# battle_menu.show()
			uiStack.pop()
			uiStack.pop()
			battle_menu.release_focus()
			battle_menu.hide_menu()
			battle_menu.release_focus()
			if selected_resource is Item:
				inventory.remove_item(selected_resource)
			emit_signal("battle_menu_resource_selected", selected_resource)

		ContextMenu.INFO:
			if selected_resource is Item or selected_resource is BattleAction:
				info_menu.text = selected_resource.description
				uiStack.push(info_menu)
