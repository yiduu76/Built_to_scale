extends Control
class_name  MyBarClass
@export var BarName:String = "无":
	set(v):
		BarName = v
		if is_node_ready():
			await get_tree().create_timer(0.5).timeout
			pass

@export var bar_max_len:float = 100.0
@export_enum("BOTH", "RIGHT", "LEFT") var bar_grove_dir = "BOTH"
@export var colors:Array[Color]

@onready var bar: Polygon2D = $Bars/bar
@onready var bar_outline: Line2D = $Bars/bar/bar_outline
@onready var bar_underground: Polygon2D = $Bars/bar_underground
@onready var bar_outline_underground: Line2D = $Bars/bar_underground/bar_outline_underground
@onready var tip_str: Label = $tip_str

@export var bars_and_lines:Array[Node]
@export var init_poly:Array[Vector2]
@export var empty_poly:Array[Vector2]

@export var max_bar_value = 100.0 :
	set(v):
		max_bar_value = v
		value_changed.emit()

@export var bar_value : float = 0.0:
	set(v):
		bar_value = v
		value_changed.emit()
@export var len = 100.0

var target_node
signal value_changed

func _ready() -> void:
	poly_and_line_init()
	value_changed.connect(value_change)

func value_change():
	set_points(bar_value,0)
	set_points(bar_value,1)
	set_points(max_bar_value,2)
	set_points(max_bar_value,3)
	display_tip()

func poly_and_line_init():
	for i in bars_and_lines:
		if i is Polygon2D:
			i.polygon = init_poly
			#i.color = colors[i]
		elif i is Line2D:
			i.points = init_poly
			#i.default_color = colors[i]

func set_points(scale_value:float,bar_or_line_index:int):
	#return
	var p_node = bars_and_lines[bar_or_line_index]
	var p_array = p_node.get("polygon")
	if p_array == null:
		p_array = p_node.get("points")
	var bar_len = (scale_value / max_bar_value) * len
	for i in p_array.size():
		if p_array[i].x < 0 and bar_grove_dir != "RIGHT":
			p_array[i].x = lerp(p_array[i].x, init_poly[i].x - bar_len,0.1)
		elif p_array[i].x > 0 and bar_grove_dir != "LEFT":
			p_array[i].x = lerp(p_array[i].x, init_poly[i].x + bar_len,0.1)
	p_node.set("polygon",p_array)
	p_node.set("points",p_array)

func display_tip():
	var p_str:String = "%s %s / %s " % [BarName,int(bar_value),int(max_bar_value)]
	tip_str.text = p_str
