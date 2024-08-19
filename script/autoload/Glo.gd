extends Node
@onready var input_dir:Vector2 = Vector2.RIGHT
@onready var last_move_action
const special_char = ["😋","💣","🏹","🐣"]
const caculate_char = ["😋","💣","🏹","🐣"]
const number_char = ["1","2","3","4","5","6","7","8","9","0"]
signal settle_emoji
signal dir_signal
@onready var hp = 100.0
@onready var origin_hp = 100.0
@onready var ey_hp = 100.0:
	set(v):
		ey_hp = v
		if ey_hp <=0 :
			ey_grove_up()
@onready var origin_ey_hp = 100.0
@onready var atk = 10.0
@onready var origin_atk = 10.0
@onready var ey_atk = 10.0
@onready var origin_ey_atk = 10.0
@onready var size = 100.0
@onready var ey_size = 100.0
@onready var level = 1

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

func ey_grove_up():
	ey_hp = origin_ey_hp + level * 20
	ey_atk = origin_ey_atk + level * 10
	level += 1

