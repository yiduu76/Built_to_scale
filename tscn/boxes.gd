extends GridContainer
@onready var p_btns:Array[Label]
@onready var btns:Array[Label]
@onready var btns_2d:Array

@onready var now_pos = Vector2.ZERO
@onready var path_array:Array[Vector2]
@onready var move_speed:int = 1
@export var chars : String = "="
var timer:Timer
const OUTLINE = preload("res://asset/ui_style/outline.tres")
const rand_pond = ["","","","","","","","","","","","","","","","","","",\
				"0","1","2","*","/","+","-","","","","","","","","","","","",]

func _ready() -> void:
	init_btns()
	init_timer()

func init_btns():
	for i in columns * columns:
		var p_button = Label.new()
		p_button.custom_minimum_size = Vector2(12,12)
		p_button.add_theme_stylebox_override("normal", OUTLINE)
		p_button.add_theme_font_size_override("font_size",5)
		p_button.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		p_button.vertical_alignment  = VERTICAL_ALIGNMENT_CENTER
		p_button.text = rand_pond.pick_random()
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
	timer.wait_time = 1.0 / move_speed
	timer.start(0)

func timer_timeout():
	do_move(Glo.input_dir)

func do_move(p_dir:Vector2):
	#update_path_chars()
	
	#path_array.append(now_pos)
	#var reverse_array = path_array
	#reverse_array.reverse()
	
	now_pos = now_pos + p_dir
	btns_2d[now_pos.y][now_pos.x].text = chars[0]
	
	#printerr(now_pos)


#func update_path_chars():
	#for i in btns:
		#i.text = ""
