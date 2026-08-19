class_name Paddle
extends CharacterBody2D

const acceleration = 70
const max_acceleration = 800
const decceleration = 40

@onready var move_up = "move_up" if name != "paddle_ai" else "ai_up"
@onready var move_down = "move_down" if name != "paddle_ai" else "ai_down"


func get_input() -> void:
	var up = Input.is_action_pressed(move_up)
	var down = Input.is_action_pressed(move_down)
	
	if up:
		velocity.y -= acceleration
	if down:
		velocity.y += acceleration
	
	velocity = velocity.clamp(Vector2(0, -max_acceleration), Vector2(0, max_acceleration))


func deccelerate() -> void:
	if velocity.y > 0:
		velocity.y -= decceleration
		if velocity.y <= 0:
			velocity.y = 0
		
	if velocity.y < 0:
		velocity.y += decceleration
		if velocity.y >= 0:
			velocity.y = 0


func bounds_stop(collision_info: KinematicCollision2D) -> void:
	var bounds_hit
	if collision_info != null:
		bounds_hit = true
	if bounds_hit:
		velocity.y = 0


func _physics_process(delta: float) -> void:
	get_input()
	var collision_info = move_and_collide(velocity * delta)
	bounds_stop(collision_info)
	deccelerate()

	$paddle_static.passed_velocity_y = velocity.y
	$paddle_static.passed_name = name
