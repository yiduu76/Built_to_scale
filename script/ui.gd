extends Control
@onready var boxes: GridContainer = $Boxes
@onready var chars_label: Label = $CharsLabel

func _on_boxes_chars_change(p_str: Variant) -> void:
	var p_ = "%s = %s " % [Glo.remove_duplicate_operators(p_str),str(Mymath.evaluate_expression(p_str))]
	#var p_ = str(Mymath.evaluate_expression("2*+3-*2/+2+-8"))
	#var p_ = str(Glo.remove_duplicate_operators(p_str))
	chars_label.text = p_
