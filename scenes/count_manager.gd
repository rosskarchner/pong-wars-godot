extends Node2D

signal score_changed

const TOTAL_BLOCKS = 576  # Total number of blocks on the board
var day_block_count = 288  # Start with half day, half night (12 columns x 24 rows)

func block_flipped(phase):
	if phase == Palette.Phase.DAY:
		day_block_count += 1
	else:
		day_block_count -= 1
	score_changed.emit(day_block_count)
