extends State
class_name PlayerDefault

@export var player : CharacterBody2D
@export var move_speed = 300.0

var movement
var sprite
var mask_switcher 

var animation = ["default","walkdown","walkleft","walkright","walkup"]

func Enter():
	print_debug("Enter ", self.name)
	mask_switcher = player.get_parent().find_child("MaskSwticher")
	mask_switcher.maskChanged.connect(_on_mask_switcher_mask_changed)
	#print_debug(mask_switcher.maskChanged.get_connections())
	sprite = player.get_child(0)
	movement = Player.Movement.new()
	movement.speed = move_speed

func Exit():
	mask_switcher.maskChanged.disconnect(_on_mask_switcher_mask_changed)
	
func Update(delta: float):
	pass
		
func Physics_Update(_delta: float):
	if player:
		var velo = movement.walk(sprite,animation)
		if velo != null:
			player.velocity = velo


func _on_mask_switcher_mask_changed(maskname):
	#print_debug(mask_switcher.switch(maskname))
	var state = mask_switcher.switch(maskname)
	#print_debug(self.name, state)
	Transitioned.emit(self,state)
	
