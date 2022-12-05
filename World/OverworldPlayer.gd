extends KinematicBody2D

const WALK_SPEED := 80
const MAX_ENCOUNTER_METER := 100
const MIN_ENCOUNTER_CHANCE := 0.1
const ENCOUNTER_METER_REDUCTION_AMOUNT := 75

var velocity := Vector2.ZERO
var encounter_meter := MAX_ENCOUNTER_METER
var encounter_chance := MIN_ENCOUNTER_CHANCE

onready var animated_sprite := get_node("AnimatedSprite")
onready var interactable_detector: Area2D = $InteractableDetector

func _ready() -> void:
	animated_sprite.set_playing(true)
	interactable_detector.rotation = Vector2.DOWN.angle()


func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_vector * WALK_SPEED
	move_and_slide(velocity)
	
	if is_moving():
		animate_walk()
		interactable_detector.rotation = velocity.angle()
		encounter_check(delta)
	else:
		animate_idle()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var interactables : Array = interactable_detector.get_overlapping_bodies()
		# I might consider making this only one interactable. 
		# i.e only use the first element in the array. 
		for interactable in interactables:
			if not interactable is Interactable : 
				continue
			interactable._run_interaction()
			get_tree().set_input_as_handled()
#		Events.emit_signal("request_show_message", "Yhe enter key")
#		SceneStack.push("res://Battle/Battle.tscn")

func encounter() -> void:
	var random_encounters = ReferenceStash.random_encounters
	if random_encounters.empty():
		return
	random_encounters.shuffle()
	ReferenceStash.encounter_class = random_encounters.front()
	SceneStack.push("res://Battle/Battle.tscn")

func encounter_check(delta : float) -> void:
	encounter_meter -= ENCOUNTER_METER_REDUCTION_AMOUNT * delta
	if encounter_meter <= 0:
		encounter_meter = MAX_ENCOUNTER_METER
		if Math.chance(encounter_chance):
			encounter_chance = MIN_ENCOUNTER_CHANCE
			encounter()
		else:
			encounter_chance = min(encounter_chance + 0.1, 1.0)


func animate_idle() -> void:
	match animated_sprite.animation:
		"WalkLeft": animated_sprite.animation = "IdleLeft"
		"WalkRight": animated_sprite.animation = "IdleRight"
		"WalkUp": animated_sprite.animation = "IdleUp"
		"WalkDown": animated_sprite.animation = "IdleDown"


func is_moving() -> bool:
	return velocity != Vector2.ZERO

func animate_walk() -> void:
	var angle := velocity.angle()
	var angle_in_degrees := rad2deg(angle)
	var rounded_angle := int(round(angle_in_degrees / 45) * 45)
	match rounded_angle:
		-135, 180, 135: animated_sprite.animation = "WalkLeft"
		-45, 0, 45: animated_sprite.animation = "WalkRight"
		-90: animated_sprite.animation = "WalkUp"
		90: animated_sprite.animation = "WalkDown"
		
