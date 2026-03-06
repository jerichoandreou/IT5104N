extends CharacterBody2D

@export var speed = 120

@onready var player = get_tree().get_first_node_in_group("player")
@onready var patrol_point1 = $PatrolPoint1
@onready var patrol_point2 = $PatrolPoint2

var target_point
var state = "patrol"

func _ready():
	target_point = patrol_point1.global_position


func _physics_process(delta):

	if state == "patrol":
		patrol()

	elif state == "chase":
		chase()

	move_and_slide()


func patrol():

	var direction = (target_point - global_position).normalized()
	velocity.x = direction.x * speed

	if global_position.distance_to(target_point) < 10:

		if target_point == patrol_point1.global_position:
			target_point = patrol_point2.global_position
		else:
			target_point = patrol_point1.global_position


func chase():

	if player == null:
		return

	var direction = (player.global_position - global_position).normalized()
	velocity.x = direction.x * speed


func _on_area_2d_body_entered(body):

	if body.name == "Player":
		state = "chase"


func _on_area_2d_body_exited(body):

	if body.name == "Player":
		state = "patrol"
