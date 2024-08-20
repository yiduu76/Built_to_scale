extends Control
class_name UIClass
@onready var chars_label: Label = $CharsLabel
static  var singleton
#@onready var hp_bar: ProgressBar = $Left/ProgressBar
#@onready var ey_hp_bar: ProgressBar = $Right/ProgressBar
@onready var hp_bar  = $Left/MyBar
@onready var ey_hp_bar = $Right/MyBar
@onready var atk_num: Label = $Left/atk_num
@onready var ey_atk_num: Label = $Right/atk_num
@onready var size_num: Label = $Left/size_num
@onready var ey_size_num: Label = $Right/size_num


func _ready() -> void:
	singleton = self

func _on_boxes_chars_change(p_str: Variant) -> void:
	var p_ = "%s = %s " % [Glo.remove_duplicate_operators(p_str),str(Mymath.evaluate_expression(p_str))]
	#var p_ = str(Mymath.evaluate_expression("2*+3-*2/+2+-8"))
	#var p_ = str(Glo.remove_duplicate_operators(p_str))
	chars_label.text = p_

func _process(delta: float) -> void:
	hp_bar.max_bar_value = Glo.origin_hp
	ey_hp_bar.max_bar_value = Glo.origin_ey_hp
	hp_bar.bar_value = Glo.hp
	ey_hp_bar.bar_value = Glo.ey_hp
	atk_num.text = "%s : %s" % ["",int(Glo.atk)]
	ey_atk_num.text = "%s : %s" % [int(Glo.ey_atk),""]
	size_num.text = "%s : %s" % ["",int(Glo.size)]
	ey_size_num.text = "%s : %s" % [int(Glo.ey_size),""]
