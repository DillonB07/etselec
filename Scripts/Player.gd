extends CharacterBody2D

@export var speed = 300.0
@export var gravity = 200
@export var jump_height = -100


func horizontal_movement():
	var hor_inp = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = hor_inp * speed

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	horizontal_movement()
	#move_and_slide()
	player_animations()

func player_animations():
	if Input.is_action_pressed("ui_left")|| Input.is_action_just_released("ui_jump"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("run")
		
	if Input.is_action_pressed("ui_right") || Input.is_action_just_released("ui_jump"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("run")
		
	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("idle")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_jump") and is_on_floor():
		velocity.y = jump_height
		$AnimatedSprite2D.play("jump")
