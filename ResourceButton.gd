extends ParentButton
class_name ResourceButton

var resource : Resource 

signal resource_selected(resource)


func _on_ResourceButton_button_down() -> void:
	emit_signal("resource_selected", resource)
