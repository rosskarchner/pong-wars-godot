extends Control

@onready var bar = %ProgressBar

func _ready():
	CountManager.score_changed.connect(update_scores)
	
func update_scores(day_score, night_score):
	#day_label.text=str(day_score)
	#night_label.text = str(night_score)
	assert(day_score+night_score == 576)
	bar.value = day_score
