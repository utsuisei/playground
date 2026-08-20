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
var ball_velocity_x

var ai_missed = false


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


func adjust() -> void:
	if not ai_missed:
		return
	ai_missed = false
	
	var too_late = Input.is_action_pressed("move_up") or Input.is_action_pressed("ai_down")
	if too_late:
		press_duration += 0.01
		print("pressing more...")     # I don't even know what I'm doing with these.
	else:
		press_duration -= 0.005
		print("  pressing less...")
	
	var too_much_break = not Input.is_action_pressed("ai_up") and not Input.is_action_pressed("ai_down")
	if too_much_break:
		press_break -= 0.01
		print("taking less break...")
	else:
		press_break += 0.004
		print("  taking more break...")


func _process(delta: float) -> void:
	ball_pos_x = ball.position.x
	ball_pos_y = ball.position.y
	paddle_pos_x = paddle.position.x
	paddle_pos_y = paddle.position.y
	ball_velocity_x = ball.linear_velocity.x
	
	var ball_towards_enemy = ball_velocity_x < 0
	if ball_towards_enemy:
		return
	
	press_control()
	
	adjust()

func _on_area_2d_body_entered(body: Ball) -> void:
	ai_missed = true
