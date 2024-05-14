extends Control

@onready var bar = %ProgressBar
@onready var progress_labels = %ProgressLabels
@onready var day_label = %DayLabel
@onready var night_label = %NightLabel

func _ready():
	CountManager.score_changed.connect(update_scores)
	
func update_scores(day_score):
	bar.value = day_score
	day_label.text = str(day_score)
	night_label.text = str(556-day_score)
	progress_labels.position.x = (day_score/556.0) * 600
