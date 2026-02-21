extends CharacterBody2D

const SPEED = 200
const JUMP_FORCE = -450
const GRAVITY = 1200

func _physics_process(delta):
	# Endless running forward
	velocity.x = SPEED

	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Jump (Space key)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE

	move_and_slide()
