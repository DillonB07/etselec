extends CharacterBody2D

@export var speed = 175.0
@export var gravity = 300
@export var jump_height = -145

var is_dashing = false
var is_climbing = false
var is_jumping = false

var current_anim


func horizontal_movement():
	var hor_inp = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	self.velocity.x = hor_inp * speed


func _physics_process(delta: float) -> void:
	# calculate movement
	self.velocity.y += gravity * delta
	horizontal_movement()
	
	# apply movement
	self.move_and_slide()

	# display animations
	if !is_climbing:
		player_animations()
		
	while is_jumping:
		var jump_strength = Input.get_action_strength("ui_jump")
		print(jump_strength)
		var jump_vel = jump_height * jump_strength
		self.velocity.y = jump_vel
	
	if self.is_on_floor():
		is_jumping = false
	

func player_animations():
	# heading left
	if Input.is_action_pressed("ui_left")|| Input.is_action_just_released("ui_jump"):
		$AnimatedSprite2D.flip_h = true
		current_anim = "run"
		$AnimatedSprite2D.play("run")

	# heading right
	if Input.is_action_pressed("ui_right") || Input.is_action_just_released("ui_jump"):
		$AnimatedSprite2D.flip_h = false
		current_anim = "run"
		$AnimatedSprite2D.play("run")
	
	if !Input.is_anything_pressed():
		current_anim = "idle"
		$AnimatedSprite2D.play("idle")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_jump") and self.is_on_floor():
		self.velocity.y = jump_height
		is_jumping = true
		current_anim = "jump"
		$AnimatedSprite2D.play("jump")

	if event.is_action_pressed("ui_dash"):
		is_dashing = true
		print("Dashing - handle movement later")

	if event.is_action_pressed("ui_climb"):
		is_climbing = true
		self.velocity.y = -200
		print("Climbing - handle movement later")


func _on_animated_sprite_2d_animation_finished() -> void:
	if current_anim == "climbing":
		is_climbing = false
	if current_anim == "dashing":
		is_dashing = false

	current_anim = null
