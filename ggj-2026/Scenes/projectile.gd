extends RigidBody2D
class_name Projectile

@export var speed : int = 30

var angle
var object 
var type
var dmg
var lifetime
 
var target : CharacterBody2D
var hpManager : HealthManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AttackBox.area_entered.connect(_on_area_entered)
	$kill.wait_time = lifetime
	$kill.start()
	var direction : Vector2
	direction.x = cos(deg_to_rad(angle))
	direction.y = sin(deg_to_rad(angle))
	#print_debug("x: %s, y: " % [direction.x,direction.y])
	
	linear_velocity = speed * direction


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_kill_timeout() -> void:
	print_debug("Kill projectile")
	self.queue_free()

func _on_area_entered(area: Area2D) -> void:
	print_debug("Area: ",area)
	#if ignore_collisions:
		#return
	#prevent from kill thy self!
	if area.is_in_group(type):
		return
	if area is HurtBox2D:
		hpManager = area.get_parent()
		target = area.get_parent().get_parent()
		print_debug("Enter Area, Target: %s, Hpmanager: %s" % [target,hpManager])
		object.damage(dmg,hpManager)
		#kill Projectile
		self.queue_free()
	
	
