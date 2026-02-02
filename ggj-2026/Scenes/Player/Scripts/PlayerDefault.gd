extends State
class_name PlayerDefault

@export var player1 : CharacterBody2D
@export var move_speed1 = 300.0 


func _ready() -> void:
	player = player1

func Enter():
	move_speed = move_speed1
	animation = ["default","walkdown","walkleft","walkright","walkup"]
	setup(player1)
	pAttack = get_parent().get_parent().find_child("PlayerAttack")
	mask_switcher.maskChanged.connect(_on_mask_switcher_mask_changed)

func Exit():
	mask_switcher.maskChanged.disconnect(_on_mask_switcher_mask_changed)
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	physics(player1, canWalk)
	
	
func _on_mask_switcher_mask_changed(maskname):
	var state = mask_switcher.switch(maskname)
	Transitioned.emit(self,state)


func _on_attack_cd_timeout() -> void:
	attackCD = false
	#canWalk = true
