extends Control

@onready var bar = %ProgressBar
@onready var progress_labels = %ProgressLabels
@onready var day_label = %DayLabel
@onready var night_label = %NightLabel

const WINDOW_WIDTH = 600  # Match window/size/viewport_width from project.godot

func _ready():
	CountManager.score_changed.connect(update_scores)

func update_scores(day_score):
	bar.value = day_score
	day_label.text = str(day_score)
	night_label.text = str(CountManager.TOTAL_BLOCKS - day_score)
	progress_labels.position.x = (float(day_score) / CountManager.TOTAL_BLOCKS) * WINDOW_WIDTH
