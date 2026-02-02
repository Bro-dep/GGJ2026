extends Area2D
class_name  HurtBox2D

@export var healthManager : HealthManager

@export var ignore_collisions : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func applyDmg(amount):
	#healthManager.damage(amount)
	#
#func applyHeal(amount):
	#healthManager.heal(amount)

func _on_area_entered(area: Area2D) -> void:
	if ignore_collisions:
		return
	
	if area is AttackBox:
		pass
		area.get_parent().find_child("HealthManager")
		
		
		
		#hit_box_entered.emit(area)
		#return
	
	#if area is not HurtBox2D:
		#unknown_area_entered.emit(area)
		#return

	#var hurt_box: HurtBox2D = area
	#hurt_box_entered.emit(hurt_box)
	#var cloned_actions := _clone_actions()
	#hurt_box.apply_all_actions(cloned_actions)
	#action_applied.emit(hurt_box)
