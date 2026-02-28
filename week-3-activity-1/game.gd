extends Node2D

var score = 0
var health = 100

@onready var score_label = $HUD/ScoreLabel
@onready var health_bar = $HUD/HealthBar

func _process(delta):
	score += int(delta * 5)
	score_label.text = "Score: " + str(score)

	health_bar.value = health
	func take_damage(amount):
	health -= amount
	if health <= 0:
		game_over()
	
