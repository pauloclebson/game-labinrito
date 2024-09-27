extends CharacterBody2D

@export var speed := 35
@export var target : Area2D
@onready var navigation: NavigationAgent2D = $NavigationAgent2D

func _physics_process(delta: float) -> void:
	var dir = to_local(navigation.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	
func go_to_target():
	navigation.target_position = target.global_position

func _on_timer_timeout() -> void:
	go_to_target()
