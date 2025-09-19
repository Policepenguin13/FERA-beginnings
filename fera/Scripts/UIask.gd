extends Control

signal asked

var ProtagVer = true
var PotentialName = "RIN"

func _ready():
	self.set_modulate(Color.WHITE)
	self.show()
	$Trans.show()
	OpeningTransition()
	# await get_tree().create_timer(1.3).timeout
	ProtagStart()

func ProtagStart():
	Globals.CanMove = false
	ProtagVer = true
	$box/name/answer.text = "RIN"
	$box/name/question.text = "What will your name be?"
	Setup()

func OpeningTransition():
	$box.hide()
	$AnimationPlayer.play("intoScene")
	await get_tree().create_timer(1.2).timeout
	$Trans.hide()
	$box.show()

func FeraStart():
	Globals.CanMove = false
	ProtagVer = false
	$box/name/answer.text = "TETO"
	$box/name/question.text = "What will your Fera's name be?"
	Setup()

func Setup():
	$box/askConfirm.hide()
	$box/answers.hide()
	$box/name.show()
	$box/answers/Yes.disabled = false
	$box/answers/No.disabled = false
	self.set_modulate(Color.WHITE)
	self.show()
	$box/name/answer.grab_focus()
	$box/name/answer.editable = true


func Next():
	$box/askConfirm.hide()
	$box/answers.hide()
	$box/name.show()
	
	# await get_tree().create_timer(1.0).timeout
	var tween = get_tree().create_tween()
	tween.tween_property($box, "modulate", Color.BLACK, 0.5)
	
	await get_tree().create_timer(0.6).timeout
	$box/askConfirm.show()
	$box/answers.show()
	$box/name.hide()
	$box/answers/Yes.grab_focus()
	
	tween = get_tree().create_tween()
	tween.tween_property($box, "modulate", Color.WHITE, 0.5)
	# print("started tweening")
	# await tween.finished
	# print("finished tweening")
	# $box/confirm.show()
	
	# tween.tween_property($box, "modulate", Color.WHITE, 0.5)
	
	# await tween.finished
	# print("hi")
#	var tween = get_tree().create_tween()
#	tween.tween_callback($Sprite.set_modulate.bind(Color.RED)).set_delay(2)
#	tween.tween_callback($Sprite.set_modulate.bind(Color.BLUE)).set_delay(2)

func _on_yes_pressed():
	$box/answers/Yes.disabled = true
	$box/answers/No.disabled = true
	$box/answers/Yes.hide()
	$box/answers/No.hide()
	# print("yes pressed")
	if ProtagVer:
		Globals.PlayerName = PotentialName.to_upper()
	else:
		Globals.FeraName = PotentialName.to_upper()
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 1.0)
	await tween.finished
	self.hide()
	if !%DialogueBox.cutscene:
		Globals.CanMove = true
	asked.emit()

func _on_no_pressed():
	# print("no pressed")
	$box/answers/Yes.disabled = true
	$box/answers/No.disabled = true
	if ProtagVer:
		ProtagStart()
	else:
		FeraStart()

func _on_answer_text_submitted(new_text):
	# print("text ("+ str(new_text) +") submitted")
	PotentialName = str(new_text).to_upper()
	$box/name/answer.editable = false
	if ProtagVer:
		$box/askConfirm.text = "Are you sure you want your name to be " + PotentialName + "?"
	else:
		$box/askConfirm.text = "Are you sure you want your fera's name to be " + PotentialName + "?"
	await get_tree().create_timer(0.2).timeout
	Next()
