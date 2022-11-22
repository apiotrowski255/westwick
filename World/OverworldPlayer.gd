extends KinematicBody2D

const WALK_SPEED = 80

var velocity := Vector2.ZERO

onready var animated_sprite := get_node("AnimatedSprite")

func _ready() -> void:
	animated_sprite.set_playing(true)


func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_vector * WALK_SPEED
	move_and_slide(velocity)
	
	if is_moving():
		animate_walk()
	else:
		animate_idle()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		SceneStack.push("res://Battle/Battle.tscn")
		

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
		
