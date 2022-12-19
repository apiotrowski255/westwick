extends Node2D
class_name Projectile

var asyncTurnPool: AsyncTurnPool = ReferenceStash.asyncTurnPool

export(float) var travel_duration := 0.5

signal contact

func move_to(target: BattleUnit, trans: int = Tween.TRANS_LINEAR, easing: int = Tween.EASE_IN) -> void:
	z_index = 25
	asyncTurnPool.append(self)
	var tween := create_tween().set_trans(trans).set_ease(easing)
	var target_position : Vector2 = Vector2(target.global_position.x, global_position.y)
	tween.tween_property(self, "global_position", target_position, travel_duration).from_current()
	yield(tween, "finished")
	emit_signal("contact")
	yield(_animate_collision(), "completed")
	asyncTurnPool.remove(self)
	queue_free()

func _animate_collision() -> void:
	yield(get_tree(), "idle_frame")
