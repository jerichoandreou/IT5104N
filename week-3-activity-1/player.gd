extends CharacterBody2D

@onready var jump_sfx = $JumpSFX
@onready var walk_sfx = $WalkSFX

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()  # 🔊 Play jump sound

	# Handle movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		# Play walking sound only if on floor
		if is_on_floor():
			if not walk_sfx.playing:
				walk_sfx.play()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		walk_sfx.stop()

	# Stop walking sound if in air
	if not is_on_floor():
		walk_sfx.stop()

	move_and_slide()
