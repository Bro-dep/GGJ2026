extends CharacterBody2D


const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

@onready var dashTimer = $Timers/DashTimer
@onready var dashDuration = $Timers/DashDuration

var speed = 300.0
var canDash := true
var canMove := true

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("Move Left", "Move Right", "Move Up", "Move Down")
	if direction and canMove:
		velocity = direction * SPEED
	elif canMove:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	if Input.is_action_just_pressed("Dash"):
		dash()
	
	move_and_slide()

func dash():
	canMove = false
	velocity = velocity * 3
	dashDuration.start()

## How long till player can dash again
func _on_dash_timer_timeout() -> void:
	canDash = true

## How long dash speed exists for
func _on_dash_duration_timeout() -> void:
	canMove = true
	dashTimer.start()
