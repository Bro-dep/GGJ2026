extends Node2D
class_name PlayerAttack

@export var attackBox : AttackBox

var target : CharacterBody2D
var hpManager : HealthManager

func _ready() -> void:
	attackBox.area_entered.connect(_on_area_entered)
	attackBox.area_exited.connect(_on_area_exited)

func damage(amount, hpManager):
	if hpManager:
		hpManager.damage(amount)
	print_debug("Target: %s, Hpmanager: %s, Amount: %s" % [target,hpManager,amount])


func shoot(amount, spriteFrames, lifetime, speed):
	var scene = preload("res://Scenes/projectile.tscn")
	var projectile = scene.instantiate()
	projectile.position = self.get_parent().position
	var roatation = rad_to_deg(atan(get_local_mouse_position().y/get_local_mouse_position().x*-1)) * -1
	#print_debug(roatation)
	if get_local_mouse_position().x < 0:
		roatation += 180
	projectile.rotation_degrees = roatation
	
	projectile.object = self
	projectile.angle = roatation
	projectile.type = "Player"
	projectile.dmg = amount
	projectile.lifetime = lifetime
	projectile.speed = speed
	
	projectile.find_child("AnimatedSprite2D").sprite_frames = spriteFrames
	
	self.get_parent().get_parent().add_child(projectile)
	

func _on_area_entered(area : Area2D):
	if area is HurtBox2D:
		hpManager = get_parent().find_child("HealthManager")
		target = area.get_parent().get_parent()
		print_debug("Enter Area, Target: %s, Hpmanager: %s" % [target,hpManager])


func _on_area_exited(area : Area2D):
	if area is HurtBox2D:
		if area.get_parent().get_parent() == target:
			print_debug("Left Area, Target: %s, Hpmanager: %s" % [target,hpManager])
			target = null
			
