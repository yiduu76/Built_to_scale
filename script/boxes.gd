extends GridContainer
@onready var p_btns:Array[Label]
@onready var btns:Array[Label]
@onready var btns_2d:Array

@onready var now_pos = Vector2.ZERO
@onready var path_array:Array[Vector2]
@onready var move_speed:int = 1:
	set(v):
		move_speed = v
		move_speed_set(move_speed)
@export var chars : String = "1":
	set(v):
		chars = v
		chars_change.emit(chars)
var timer:Timer
const OUTLINE = preload("res://asset/ui_style/outline.tres")
const BODY = preload("res://asset/ui_style/body.tres")
const rand_pond = ["","","","","","","","","","","","","","","","","","",\
				"0","1","2","*","/","+","-","3","4","5","","","","","","","","",]
signal chars_change(p_str)

func _ready() -> void:
	init_btns()
	init_timer()
	path_array.append(now_pos)

@onready var speed_up_tick = 0
@onready var speed_up_need_tick = 120
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_speed_up"):
		move_speed = 3
	else :
		move_speed = 1

func move_speed_set(p_speed):
	timer.wait_time = 1.0 / p_speed

func init_btns():
	for i in columns * columns:
		var p_button = Label.new()
		p_button.custom_minimum_size = Vector2(12,12)
		p_button.add_theme_stylebox_override("normal", OUTLINE)
		p_button.add_theme_font_size_override("font_size",5)
		p_button.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		p_button.vertical_alignment  = VERTICAL_ALIGNMENT_CENTER
		if i == 0:
			pass
		else :
			p_button.text = [rand_pond.pick_random(),""].pick_random()
		add_child(p_button)
		btns.append(p_button)
		p_btns.append(p_button)
		if (i+1) % columns == 0:
			btns_2d.append(p_btns)
			p_btns = []
	#printerr(btns_2d[14].size())

func init_timer():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(timer_timeout)
	move_speed_set(move_speed)
	timer.start(0)

func timer_timeout():
	do_move(Glo.input_dir)

func do_move(p_dir:Vector2):
	now_pos = now_pos + p_dir
	if now_pos.x > 14 or now_pos.y > 14 or now_pos.x < 0 or now_pos.y < 0:
		get_tree().quit()
	var get_char = btns_2d[now_pos.y][now_pos.x].text
	if get_char != "":
		chars += get_char
	
	path_array.append(now_pos)
	var p_arrray:Array = Glo.reverse_array(path_array)
	var p_char = Glo.reverse_string(chars)
	var final_array = []
	
	for i in (p_char.length() + 1):
		final_array.append(p_arrray.pop_front())
		
	for i in final_array.size():
		var p_x = final_array[i].y
		var p_y = final_array[i].x
		var p_btn = btns_2d[p_x][p_y]
		if i < p_char.length():
			btns_2d[p_x][p_y].text = p_char[i]
			(btns_2d[p_x][p_y] as Label).add_theme_stylebox_override("normal",BODY)
		else :
			btns_2d[p_x][p_y].text = ""
			(btns_2d[p_x][p_y] as Label).add_theme_stylebox_override("normal",OUTLINE)
