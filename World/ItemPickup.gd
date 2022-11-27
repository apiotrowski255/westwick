extends Interactable

var inventory : Inventory = ReferenceStash.inventory

export(Resource) var item : Resource setget set_item
onready var sprite: Sprite = $Sprite

func set_item (value : Item) -> void:
	item = value
	call_deferred("set_sprite_texture", item)

func set_sprite_texture(item) -> void:
	sprite.texture = item.overworld_sprite

func _run_interaction() -> void:
	inventory.add_item(item)
	var vowel : String = "a"
	if begins_with_vowel(item.name):
		vowel = "an"
#	Events.emit_signal("request_show_message", "You found " + vowel + " " + str(item.name) + ".\n" + str(item.description))
	Events.emit_signal("request_show_message", "You found " + vowel + " " + str(item.name) + ".")
	queue_free()

func begins_with_vowel(string : String) -> bool:
	return (str(item.name).begins_with("a") or 
			str(item.name).begins_with("i") or 
			str(item.name).begins_with("o") or 
			str(item.name).begins_with("u") or 
			str(item.name).begins_with("e") or 
			str(item.name).begins_with("A") or 
			str(item.name).begins_with("I") or 
			str(item.name).begins_with("U") or 
			str(item.name).begins_with("O") or 
			str(item.name).begins_with("E"))
