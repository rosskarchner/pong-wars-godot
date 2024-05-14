extends Control

@onready var bar = %ProgressBar

func _ready():
	CountManager.score_changed.connect(update_scores)
	
func update_scores(day_score):
	bar.value = day_score
