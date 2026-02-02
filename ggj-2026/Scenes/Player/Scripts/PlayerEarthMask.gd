extends State
class_name PlayerEarthMask

@export var player1 : CharacterBody2D
@export var move_speed1 := 300.0

func _ready() -> void:
	player = player1

func Enter():
	move_speed = move_speed1
	animation = ["earthdefault","earthwalkdown","earthwalkleft","earthwalkright","walkup"]
	setup(player1)
	pAttack = get_parent().get_parent().find_child("PlayerAttack")
	mask_switcher.maskChanged.connect(_on_mask_switcher_mask_changed)

func Exit():
	mask_switcher.maskChanged.disconnect(_on_mask_switcher_mask_changed)
	
func Update(delta: float):
	if Input.is_action_just_pressed("Attack") and !attackCD:
		#attackCD = true
		#$"../../Timers/AttackCd".start()
		#Instanciate projectile
		#pAttack.damage(10)
		var spriteFrame = preload("res://Assets/attacks/earthstrike.tres") #NOTE to be fixed
		pAttack.shoot(10, spriteFrame, 1, 150)
		#print_debug("attack")
		
func Physics_Update(_delta: float):
	physics(player1, canWalk)
	
	
func _on_mask_switcher_mask_changed(maskname):
	var state = mask_switcher.switch(maskname)
	Transitioned.emit(self,state)
