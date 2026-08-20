class_name Ball
extends RigidBody2D

const min_speed = 300
const min_speed_x = 500
const thrust_when_slow = 200
const thrust_when_slow_x = 100
const thrust_on_hit = 10000

@onready var start_x = position.x
@onready var start_y = position.y

signal hit


func random_start_angle() -> void:
	var right_side = randi() % 2 == 0
	rotation = PI * randf_range(0.3, 0.8)
	if right_side:
		rotation += PI


func _ready() -> void:
	random_start_angle()
	linear_velocity = Vector2(0, min_speed).rotated(rotation)


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var linear_x_normal = state.linear_velocity.x / abs(state.linear_velocity.x)
	var linear_y_normal = state.linear_velocity.y / abs(state.linear_velocity.y)
	
	var too_slow = state.linear_velocity.length() < min_speed
	if too_slow:
		state.apply_force(Vector2(linear_x_normal * thrust_when_slow
														, linear_y_normal * thrust_when_slow))
	
	var going_vertical = abs(state.linear_velocity.x) < min_speed_x
	if going_vertical:
		state.apply_force(Vector2(linear_x_normal * thrust_when_slow_x, 0))
	
	var contact_count = state.get_contact_count()
	if contact_count > 0:
		var collider = state.get_contact_collider_object(0)
		var is_paddle = collider.name == "paddle_static"
		if is_paddle:
			state.apply_force(Vector2(linear_x_normal * thrust_on_hit, collider.passed_velocity_y * 40))
			
			hit.emit(collider.passed_name)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	position = Vector2(start_x, start_y)
