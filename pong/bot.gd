extends Node2D

@export var paddle: Paddle
@export var ball: Ball

@export var press_duration: float
var press_duration_t = 0.0
@export var press_break: float
var press_break_t = 0.0

var ball_pos_x
var ball_pos_y
var paddle_pos_x
var paddle_pos_y

var last_ball_x = 0.0
var last_ball_y = 0.0


func simple_decide() -> void:
	var paddle_higher = paddle_pos_y < ball_pos_y
	if paddle_higher:
		Input.action_press("ai_down")
	else:
		Input.action_press("ai_up")
		


func press_control() -> void:
	var is_pressing = Input.is_action_pressed("ai_down") or Input.is_action_pressed("ai_up")
	var is_on_break = press_break_t < press_break
	
	if is_on_break:
		press_break_t += get_process_delta_time()
		return
	
	if is_pressing:
		press_duration_t += get_process_delta_time()
		if press_duration_t >= press_duration:
			press_duration_t = 0
			press_break_t = 0
			Input.action_release("ai_up")
			Input.action_release("ai_down")
		return
	
	simple_decide()


func _process(delta: float) -> void:
	ball_pos_x = ball.position.x
	ball_pos_y = ball.position.y
	paddle_pos_x = paddle.position.x
	paddle_pos_y = paddle.position.y

	press_control()
