extends CanvasLayer


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Mask Select"):
		$AnimationPlayer.play("Fade in")
		
	elif Input.is_action_just_released("Mask Select"):
		$AnimationPlayer.play("Fade out")
		var mask = $MaskSwticher.Close()
		$Label.text = mask
