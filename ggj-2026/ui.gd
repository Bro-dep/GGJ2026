extends CanvasLayer

var mask_switcher

func _ready() -> void:
	%MaskSwticher.maskChanged.connect(_on_mask_switcher_mask_changed)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Mask Select"):
		$AnimationPlayer.play("Fade in")
		
	elif Input.is_action_just_released("Mask Select"):
		$AnimationPlayer.play("Fade out")
		var mask = $MaskSwticher.Close()
		#print(mask_switcher.maskChanged.get_connections())
		#$Label.text = mask

func _on_mask_switcher_mask_changed(name):
	#print("Switch")
	$Label.text = name
