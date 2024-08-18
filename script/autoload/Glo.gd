extends Node
@onready var input_dir:Vector2 = Vector2.RIGHT
@onready var last_move_action
const special_char = ["😋","💣","🏹","🐣"]
signal settle_emoji
signal dir_signal
@onready var hp = 100.0
	#set(v):
		#if hp >= 100.0:
			#hp = 100.0
		#else :
			#hp = v
@onready var ey_hp = 100.0
	#set(v):
		#if ey_hp >= 100.0:
			#ey_hp = 100.0
		#else :
			#ey_hp = v
@onready var atk = 10.0
@onready var ey_atk = 10.0

func reverse_string(s: String) -> String:
	var reversed: String = ""
	for i in range(s.length()):
		reversed = s[i] + reversed
	return reversed

func reverse_array(a: Array) -> Array:
	var p_a: Array = []
	for i in a.size():
		var p_ = a.size() - i - 1
		p_a.append(a[p_])
	return p_a

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("ui_left") and input_dir != Vector2(1,0):
			input_dir = Vector2(-1,0)
			dir_signal.emit(input_dir)
		if event.is_action_pressed("ui_right") and input_dir != Vector2(-1,0):
			input_dir = Vector2(1,0)
			dir_signal.emit(input_dir)
		if event.is_action_pressed("ui_up") and input_dir != Vector2(0,1):
			input_dir = Vector2(0,-1)
			dir_signal.emit(input_dir)
		if event.is_action_pressed("ui_down") and input_dir != Vector2(0,-1):
			input_dir = Vector2(0,1)
			dir_signal.emit(input_dir)

func remove_duplicate_operators(input_string: String) -> String:
	var pond = ['+', '-', '*', '/']
	var kill_open = false
	var new_str:String = ""
	for i in input_string:
		if i in pond:
			if new_str.right(1) in pond:
				pass
			else :
				new_str += i
		else :
			new_str += i
	return new_str
