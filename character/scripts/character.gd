extends CharacterBody2D
var _state_machine

@export var speed := 35
@export var target : Area2D
@onready var navigation: NavigationAgent2D = $NavigationAgent2D

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

func _ready() -> void:
	_state_machine = _animation_tree["parameters/playback"]

func _physics_process(delta: float) -> void:
	var dir = to_local(navigation.get_next_path_position()).normalized()
	velocity = dir * speed
	_animate()
	move_and_slide()
	
	if dir != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = dir
		_animation_tree["parameters/walk/blend_position"] = dir
		return
	
	
func go_to_target():
	navigation.target_position = target.global_position
	
func _animate() -> void:
	if velocity.length() > 2:
		_state_machine.travel("walk")
		return
	_state_machine.travel("idle")

func _on_timer_timeout() -> void:
	go_to_target()
