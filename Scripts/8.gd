extends Node2D

func _ready() -> void:
	get_tree().paused = true
	var minuty = int(Global.time) / 60
	var sekundy = float(Global.time) - 60.0 * minuty
	$CanvasLayer/RichTextLabel.text = '
	
[center]YOU BROKE THE CURSE
YOU DIED [color=red] ' + str(Global.deaths) +' [/color] TIMES
WITH A FINAL TIME OF [color= green] '+str(minuty) + 'min ' + str(sekundy) +'s [/color]
THANKS FOR PLAYING THE DEMO
MADE BY
MAKS DZIALOWSKI
TOMASZ OLCHOWY[/center]
'
	get_tree().paused = true
