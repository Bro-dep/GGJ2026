extends CanvasLayer


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Mask Select"):
		$MaskSwticher.show()
	elif Input.is_action_just_released("Mask Select"):
		$MaskSwticher.hide()
