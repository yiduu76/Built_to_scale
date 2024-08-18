extends GridContainer
@onready var p_btns:Array[Label]
@onready var btns:Array[Label]
@onready var btns_2d:Array
@onready var now_pos = Vector2.ZERO
@onready var path_array:Array[Vector2]
@onready var move_speed:int = 1
@export var chars : String = "1":
	set(v):
		chars = v
		chars_change.emit(chars)
var dir:Vector2:
	set(v):
		dir = v
		do_move(v)
		timer.start(0)
var timer:Timer
const OUTLINE = preload("res://asset/ui_style/outline.tres")
const BODY = preload("res://asset/ui_style/body.tres")
const rand_pond = ["","","","","","","","","","","","","","","","","","",\
				"0","1","2","*","/","+","-","3","4","5","","","😋","💣","🏹","🐣"]
signal chars_change(p_str)

func _ready() -> void:
	init_btns()
	init_timer()
	Glo.dir_signal.connect(on_dir_signal_emit)
	path_array.append(now_pos)

func on_dir_signal_emit(p_dir:Vector2):
	dir = p_dir

func init_btns():
	for i in columns * columns:
		var p_button = Label.new()
		p_button.custom_minimum_size = Vector2(12,12)
		p_button.add_theme_stylebox_override("normal", OUTLINE)
		p_button.add_theme_font_size_override("font_size",5)
		p_button.add_theme_color_override("font_color",Color.BLACK)
		p_button.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		p_button.vertical_alignment  = VERTICAL_ALIGNMENT_CENTER
		if i == 0 or i == 1:
			pass
		else :
			p_button.text = [rand_pond.pick_random()].pick_random()
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
	#move_speed_set(move_speed)
	timer.start(0)

func timer_timeout():
	dir = Glo.input_dir

func settle_scale_num(target_char:String):
	var caculate_num = Mymath.evaluate_expression(chars)
	Glo.settle_emoji.emit(target_char,caculate_num)
	
	var final_array:Array = Glo.reverse_array(path_array)
	for i in final_array.size():
		var p_x = final_array[i].y
		var p_y = final_array[i].x
		var p_btn = btns_2d[p_x][p_y]
		btns_2d[p_x][p_y].text = ""
		(btns_2d[p_x][p_y] as Label).add_theme_stylebox_override("normal",OUTLINE)
	chars = "1"

func do_move(p_dir:Vector2):
	now_pos = now_pos + p_dir
	if now_pos.x > 14 or now_pos.y > 14 or now_pos.x < 0 or now_pos.y < 0:
		get_tree().quit()
		return
	var get_char = btns_2d[now_pos.y][now_pos.x].text
	
#	这里进行特殊结算的判定
	if get_char != "":
		if get_char in Glo.special_char:
			settle_scale_num(get_char)
		else :
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
