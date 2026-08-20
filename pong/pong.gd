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


func _on_punisher_body_entered(body: Ball) -> void:
	score.score -= 1
	score.text = str(score.score)


func _on_punisher_2_body_entered(body: Node2D) -> void:
	score_ai.score -= 1
	score_ai.text = str(score_ai.score)
