extends CharacterBody2D

@export var speed = 300.0
@export var gravity = 200


func horizontal_movement():
	var hor_inp = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = hor_inp * speed

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	horizontal_movement()
	move_and_slide()
