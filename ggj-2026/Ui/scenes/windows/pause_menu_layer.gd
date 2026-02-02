extends CanvasLayer

@onready var pause_menu = %PauseMenu

func _on_pause_menu_hidden():
	hide()

func _on_visibility_changed():
	if visible:
		pause_menu.show()

func _ready():
	visibility_changed.connect(_on_visibility_changed)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		visible = true
