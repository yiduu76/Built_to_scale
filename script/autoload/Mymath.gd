extends Node

func evaluate_expression(expression: String) -> float:
	expression = expression.replace(" ", "")
	expression = Glo.remove_duplicate_operators(expression)
	var priority = {
		"*": 2,
		"/": 2,
		"+": 1,
		"-": 1
	}
	
	var tokens = []
	var buffer = ""
	for char in expression:
		if char in ["+", "-", "*", "/"]:
			if buffer != "":
				tokens.append(buffer)
				buffer = ""
			tokens.append(char)
		else:
			buffer += char
	if buffer != "":
		tokens.append(buffer)
		
	if tokens.size() > 0 and tokens[tokens.size() - 1] in ["+", "-", "*", "/"]:
		tokens.pop_back()
		
	var values = []
	var ops = []
		
	for token in tokens:
		if token in ["+", "-", "*", "/"]:
			while (ops.size() > 0 and priority[ops[ops.size() - 1]] >= priority[token]):
				values.append(apply_operator(ops.pop_back(), values.pop_back(), values.pop_back()))
			ops.append(token)
		else:
			values.append(float(token))
	
	while ops.size() > 0:
		values.append(apply_operator(ops.pop_back(), values.pop_back(), values.pop_back()))
	return values[0]

# 应用操作符
func apply_operator(op: String, b: float, a: float) -> float:
	match op:
		"*":
			return a * b
		"/":
			return a / b
		"+":
			return a + b
		"-":
			return a - b
		_:
			return 0.0

func _ready() -> void:
	pass
