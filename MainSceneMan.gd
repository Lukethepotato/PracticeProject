extends Node

@export var mob_scene: PackedScene;
var score = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func GameOver():
	#called when player hit signal
	$ScoreTimer.stop();# Replace with function body.
	$MobTimer.stop();
	
func NewGame():
	score = 0
	$PlayerNode.start($StartPosition.position)
	$StartTimer.start()


func _on_mob_timer_timeout() -> void:
	pass # Replace with function body.


func _on_score_timer_timeout():
	score =+ 1


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
