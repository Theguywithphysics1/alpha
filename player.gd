extends CharacterBody2D

const ACCELERATION = 800
const FRICTION = 500
const MAX_SPEED = 120

enum {idle, run}
var state = idle

@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]

var blend_position : Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/idle/idle_bs2d/blend_position",
	"parameters/run/run_bs2d/blend_position"
]
var animTree_state_keys = [
	"idle",
	"run"
]

func _physics_process(delta):
	move(delta)
	animate()

func move(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_vector == Vector2.ZERO:
		state = idle
		apply_friction(FRICTION * delta)
	else:
		state = run
		apply_movement(input_vector * ACCELERATION * delta)
		blend_position = input_vector
	move_and_slide()


func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)

func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)


func _on_pickuparea_area_entered(area):
	if area.is_in_group ("leaf"):
		area.queue_free()
		
