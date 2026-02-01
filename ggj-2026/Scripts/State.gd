extends Node
class_name State

signal Transitioned

var movement
var sprite
var mask_switcher 
var animation
var player
var move_speed
var selfVar

func _init() -> void:
	pass
	
func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass

func setup(player):
	mask_switcher = player.get_parent().find_child("MaskSwticher")
	sprite = player.get_child(0)
	movement = Player.Movement.new()
	movement.speed = move_speed
	sprite.play(animation[0])

func physics(player):
	if player:
		var velo = movement.walk(sprite,animation)
		if velo != null:
			player.velocity = velo
