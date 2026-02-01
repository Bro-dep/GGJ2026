extends State
class_name PlayerWaterMask

@export var player1 : CharacterBody2D
@export var move_speed1 := 300.0

func _ready() -> void:
	player = player1

func Enter():
	move_speed = move_speed1
	animation = ["waterdefault","waterwalkdown","waterwalkleft","waterwalkright","walkup"]
	setup(player1)
	mask_switcher.maskChanged.connect(_on_mask_switcher_mask_changed)

func Exit():
	super()
	mask_switcher.maskChanged.disconnect(_on_mask_switcher_mask_changed)
	
func Update(delta: float):
	if Input.is_action_just_pressed("Test"):
		Transitioned.emit(self,"PlayerWaterMask")
		
func Physics_Update(_delta: float):
	physics(player1)
	
	
func _on_mask_switcher_mask_changed(maskname):
	var state = mask_switcher.switch(maskname)
	Transitioned.emit(self,state)
