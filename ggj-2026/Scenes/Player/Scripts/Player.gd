extends CharacterBody2D
class_name Player

## Player Script

const SPEED = 300.0


@onready var sprite = $AnimatedSprite2D
@onready var dashTimer = $Timers/DashTimer
@onready var dashDuration = $Timers/DashDuration

func _ready() -> void:
	var mask_switcher = Mask_Switcher.new()
	mask_switcher.maskChanged.connect(_on_mask_switcher_mask_changed)

var speed = 300.0
var canDash := true
var canMove := true

func _physics_process(_delta: float) -> void:

	#region Moevment
	#var direction := Input.get_vector("Move Left", "Move Right", "Move Up", "Move Down")
	#if direction and canMove:
		#velocity = direction * SPEED
		##NOTE Need to change walk animation based on mask equiped
		#if direction == Vector2(0,1):
			#sprite.set_animation("walkdown")
		#elif direction == Vector2(-1,0):
			#sprite.set_animation("walkleft")
		#elif direction == Vector2(1,0):
			#sprite.set_animation("walkright")
		#elif direction == Vector2(0,-1):
			#sprite.set_animation("walkup")
		
	#elif canMove:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.y = move_toward(velocity.y, 0, SPEED)
		#if sprite.get_animation() != "default":
			#sprite.set_animation("default")
	#if Input.is_action_just_pressed("Dash"):
		#dash()
	
	move_and_slide()
	#endregion 

func dash():
	canMove = false
	velocity = velocity * 3
	dashDuration.start()

#region Timers

## How long till player can dash again
func _on_dash_timer_timeout() -> void:
	canDash = true

## How long dash speed exists for
func _on_dash_duration_timeout() -> void:
	canMove = true
	dashTimer.start()

#endregion

#region Signals
func _on_mask_switcher_mask_changed(name):
	
	pass
#endregion


## Defines movement functions for player movement.
class Movement:
	var speed: float = 300.0
	var velocity : Vector2
	
	func walk(sprite,ani, canWalk : bool):
		var direction := Input.get_vector("Move Left", "Move Right", "Move Up", "Move Down")
		if direction and canWalk:
			#print_debug(ani)
			velocity = direction * speed
			if direction == Vector2(0,1):
				sprite.play(ani[1])
			elif direction == Vector2(-1,0):
				sprite.play(ani[2])
			elif direction == Vector2(1,0):
				sprite.play(ani[3])
			elif direction == Vector2(0,-1):
				sprite.play(ani[4])
		
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
			if sprite.get_animation() != ani[0]:
				sprite.play(ani[0])
		return velocity
	
	
