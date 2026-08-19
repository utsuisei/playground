extends Node

@onready var score = $score
@onready var score_ai = $score2


func _on_ball_hit(paddle: String) -> void:
	if paddle == "paddle":
		score.score += 1
		score.text = str(score.score)
	if paddle == "paddle_ai":
		score_ai.score += 1
		score_ai.text = str(score_ai.score)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("shit")
	$ball.position = $ball.default_x
	$ball.position = $ball.default_y
	$ball.random_start_angle()
