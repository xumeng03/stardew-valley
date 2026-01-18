extends StaticBody2D

signal next_day_signal()

func interact(_player: Node2D) -> void:
	next_day_signal.emit()
