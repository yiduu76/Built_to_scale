extends Node
@onready var input_dir:Vector2 = Vector2.RIGHT
@onready var last_move_action


func _process(_delta: float) -> void:
	pass

func reverse_string(s: String) -> String:
	var reversed: String = ""
	for i in range(s.length()):
		reversed = s[i] + reversed
	return reversed

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("ui_left") and input_dir != Vector2(1,0):
			input_dir = Vector2(-1,0)
		if event.is_action_pressed("ui_right") and input_dir != Vector2(-1,0):
			input_dir = Vector2(1,0)
		if event.is_action_pressed("ui_up") and input_dir != Vector2(0,1):
			input_dir = Vector2(0,-1)
		if event.is_action_pressed("ui_down") and input_dir != Vector2(0,-1):
			input_dir = Vector2(0,1)
