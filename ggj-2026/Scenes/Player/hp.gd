extends Node2D
class_name HealthManager

signal damaged(object: Node, amount)

@export_category("Health")
@export var maxHealth : int = 100
@export var current_health : int = 100 :
	set(current):
		current_health = clampi(current,0,maxHealth)

@export_group("Conditions")
## Allows the object to be damaged.
@export var damageable : bool = true
## Allows the object to be healed.
@export var healable : bool = true
## Allows the object to be killed.
@export var killable : bool = true
## Allows the object to be revived.
@export var revivable : bool = true

@export_group("Extras")
## Use if you need to set the Object to something other than the parent. [br]
## By default sets to parent Node.
@export var object : Node:
	get():
		return object if object else owner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dead():
		get_parent().queue_free()


#region Returning Functions
## Returns [code]true[/code] if hp == 0.
func is_dead() -> bool:
	return current_health == 0 and killable

## Returns [code]true[/code] if hp > 0.
func is_alive() -> bool:
	return not is_dead()

## Returns [code]true[/code] if hp is full.
func is_full() -> bool:
	return current_health == maxHealth

## Returns a value between 0 and 1 for percent of hp remaining.
func percentHp() -> float:
	return clampf(float(current_health)/float(maxHealth), 0.0, 1.0)
#endregion


## Damages by amount
func damage(amount):
	if not damageable:
		print_debug("%s cannot be damaged" % object)
		return
	
	if is_dead():
		print_debug("%s is already dead" % object)
		return
	
	current_health -= amount # Sets current hp
	print_debug("Current HP: %s" % current_health)
	
	if is_dead():
		pass
		#kill object
		
	
## Heals by amount
func heal(amount):
	if not healable:
		print_debug("%s is not healable" % object)
		return
		
	if is_full():
		print_debug("%s is full hp" % object)
		return
		
	if is_dead() and not revivable:
		print_debug("%s cannot be revived" % object)
		return
	
	current_health += amount # Sets current hp
	print_debug("Current HP: %s" % current_health)
