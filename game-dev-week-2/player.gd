extends CharacterBody2D

# Movement constants
const SPEED = 200
const JUMP_FORCE = -450
const GRAVITY = 1200

# Dodge constants
const DODGE_SPEED = 600
const DODGE_TIME = 0.15
var dodging = false

# Fall restart limit
const FALL_LIMIT = 600

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Normal movement
	var direction = Input.get_axis("ui_left", "ui_right")
	if not dodging:
		velocity.x = direction * SPEED

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE

	# Dodge (Shift key)
	if Input.is_action_just_pressed("dodge") and direction != 0 and not dodging:
		dodge(direction)

	move_and_slide()

	# Restart if player falls
	if position.y > FALL_LIMIT:
		restart_level()

# Dodge function
func dodge(dir):
	dodging = true
	velocity.x = dir * DODGE_SPEED
	await get_tree().create_timer(DODGE_TIME).timeout
	dodging = false

# Restart function
func restart_level():
	get_tree().reload_current_scene()
