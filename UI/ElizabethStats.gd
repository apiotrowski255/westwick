extends PanelContainer

var stats : PlayerClassStats = ReferenceStash.elizabethStats

onready var level: Label = $"%Level"
onready var health_bar: TextureRect = $"%HealthBar"
onready var experience_bar: TextureRect = $"%ExperienceBar"

signal animation_finished

func _ready() -> void:
	stats.connect("health_changed", self, "_on_health_changed")
	update_stats()

func update_stats() -> void:
	level.text = "Level : " + str(stats.level)
	health_bar.set_bar(stats.health, stats.max_health)
	experience_bar.set_bar(stats.experience, stats.MAX_EXPERIENCE)

func _on_health_changed() -> void:
	health_bar.animate_bar(stats.health, stats.max_health)
	yield(health_bar, "animation_finished")
	emit_signal("animation_finished")
