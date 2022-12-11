extends FocusMenu
class_name BattleMenu

const ANIMATION_DURATION := 0.4
const ANIMATION_DISTANCE := Vector2(0, 36)

enum {
	ACTION,
	ITEM,
	RUN
}

onready var item_button: TextureButton = $"%ItemButton"
onready var action_button: TextureButton = $"%ActionButton"
onready var run_button: TextureButton = $"%RunButton"

signal menu_option_selected(option)

func show_menu() -> void:
	show()
	var tween := create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		self, 
		"rect_global_position", 
		-ANIMATION_DISTANCE, 
		ANIMATION_DURATION
	).as_relative().from_current()
	yield(tween, "finished")
	
func hide_menu() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		self, 
		"rect_global_position", 
		ANIMATION_DISTANCE, 
		ANIMATION_DURATION
	).as_relative().from_current()
	yield(tween, "finished")
	hide()

func _on_ActionButton_pressed() -> void:
	emit_signal("menu_option_selected", ACTION)

func _on_ItemButton_pressed() -> void:
	emit_signal("menu_option_selected", ITEM)

func _on_RunButton_pressed() -> void:
	emit_signal("menu_option_selected", RUN)
