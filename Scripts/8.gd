extends Node2D

func _ready() -> void:
	get_tree().paused = true
	$CanvasLayer/RichTextLabel.text = '
	
[center]YOU BROKE THE CURSE
YOU DIED [color=red] ' + str(Global.deaths) +' [/color] TIMES
WITH A FINAL TIME OF [color= green] '+str(Global.time)+'s [/color]
THANKS FOR PLAYING THE DEMO
MADE BY
MAKS DZIALOWSKI
TOMASZ OLCHOWY[/center]
'
	get_tree().paused = true
