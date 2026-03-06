extends Node2D

var score = 0
var health = 100

@onready var score_label = $HUD/ScoreLabel
@onready var health_bar = $HUD/HealthBar


func _process(delta):
	# Increase score over time
	score += int(delta * 5)
	score_label.text = "Score: " + str(score)

	# Update health bar
	health_bar.value = health


func take_damage(amount):
	# Reduce player health
	health -= amount
	
	if health < 0:
		health = 0

	if health <= 0:
		game_over()


func game_over():
	print("Game Over")
