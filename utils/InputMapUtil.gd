extends Node

class_name InputMapUtil

static func _add_action(action: String, keycode: int):
	if not InputMap.has_action(action):
		InputMap.add_action(action)

	var iek = InputEventKey.new()
	iek.keycode = keycode
	InputMap.action_add_event(action, iek)
	print(action+" registration successful!")


static func add_actions(actions: Dictionary):
	for action in actions:
		_add_action(action, actions[action])
