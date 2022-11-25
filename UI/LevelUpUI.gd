extends TextureRect

onready var experience_bar: TextureRect = $"%ExperienceBar"

func level_up() -> void:
	show()
	experience_bar.set_bar(50, 100)
	yield(experience_bar.animate_bar(100, 100), "completed")
