extends HBoxContainer
class_name BattleMenu

enum {
	ACTION,
	ITEM,
	RUN
}

onready var item_button: TextureButton = $"%ItemButton"
onready var action_button: TextureButton = $"%ActionButton"
onready var run_button: TextureButton = $"%RunButton"

signal menu_option_selected(option)

func grab_action_focus() -> void:
	action_button.grab_focus()

func _on_ActionButton_pressed() -> void:
	emit_signal("menu_option_selected", ACTION)

func _on_ItemButton_pressed() -> void:
	emit_signal("menu_option_selected", ITEM)

func _on_RunButton_pressed() -> void:
	emit_signal("menu_option_selected", RUN)
