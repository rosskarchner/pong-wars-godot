extends Node2D

signal score_changed

var day_block_count = 12 * 24
var night_block_count = 12 * 24


func block_flipped(phase):
	if phase == Palette.Phase.DAY:
		day_block_count += 1
		night_block_count -=1
	else:
		day_block_count -= 1
		night_block_count +=1
	score_changed.emit(day_block_count,night_block_count)
	
