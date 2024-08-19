extends Control
class_name UIClass
@onready var boxes: GridContainer = $Boxes
@onready var chars_label: Label = $CharsLabel
static  var singleton
@onready var hp_bar: ProgressBar = $Left/ProgressBar
@onready var ey_hp_bar: ProgressBar = $Right/ProgressBar

@onready var atk_num: Label = $Left/atk_num
@onready var ey_atk_num: Label = $Right/atk_num


func _ready() -> void:
	singleton = self

func _on_boxes_chars_change(p_str: Variant) -> void:
	var p_ = "%s = %s " % [Glo.remove_duplicate_operators(p_str),str(Mymath.evaluate_expression(p_str))]
	#var p_ = str(Mymath.evaluate_expression("2*+3-*2/+2+-8"))
	#var p_ = str(Glo.remove_duplicate_operators(p_str))
	chars_label.text = p_

func _process(delta: float) -> void:
	hp_bar.value = Glo.hp
	ey_hp_bar.value = Glo.ey_hp
	atk_num.text = "%s : %s" % ["🏹",Glo.atk]
	ey_atk_num.text = "%s : %s" % ["💣",Glo.ey_atk]
