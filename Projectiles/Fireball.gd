extends Projectile

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var flame: CPUParticles2D = $Flame
onready var explosion: CPUParticles2D = $Explosion

func _animate_collision() -> void:
	animated_sprite.hide()
#	flame.hide()
	flame.emitting = false
	explosion.emitting = true
#	while explosion.emitting == true:
#		yield(get_tree(), "idle_frame")
	yield(get_tree().create_timer(flame.lifetime * .75), "timeout")
	emit_signal("collision_animation_finished")
