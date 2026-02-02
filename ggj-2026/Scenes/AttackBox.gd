extends Area2D
class_name AttackBox


@export var ignore_collisions : bool
@export var enemy : bool

@export var type : String

var target : CharacterBody2D
var hpManager : HealthManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



# If area is HurtBox2D
	#var hpManager = area.get_parent().find_child("HealthManager")
# 	If area is enemy:

#	If area is player:
#		#Play attack animation, Start Timer
		#
