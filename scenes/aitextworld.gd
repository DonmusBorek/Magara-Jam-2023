
# label ayarlarında autowrap ı word(smart yap) sonra labelı genişlet
# başka text eklemek isteyince array ekle
# timer autostart ve oneshot
#timer on_timeout connectle
extends Label

@onready var timer = $"../Timer"

var _current_text : String
 
var _text_sequence
var _letter_index = 0
var _text_number = 0

var _letter_time = 0.03
var _space_time = 0.06
var _punctuation_time = 1.5

var _display_finished = false

signal display_finished()

func _ready():
	await get_tree().create_timer(0.5).timeout
	if State.currentWorld == 0:
		_text_sequence = ["Burası da neresi.","Hey!","Sen neden buradasın.",""]
	if State.currentWorld == 1:
		_text_sequence = ["Hepsi öldü sanıyordum.","Buradan çıkman gerekiyor.",""]
	if State.currentWorld == 2:
		_text_sequence = ["Görüş Sistemin bozuk.","Yeni bir tane bul.",""]
	if State.currentWorld == 3:
		_text_sequence = ["Kapıları açmak için bütün canlıları ","öldürmen gerekiyor.","Kalpleri sadece bıçakla ","patlatabilirsin.",""]
	if State.currentWorld == 4:
		_text_sequence = ["Savaş başladığından beri böyleler.","Huzur içindeydik.",""]
	if State.currentWorld == 6:
		_text_sequence = ["Sen diğerlerinden farklısın.","Seni incelersek belki.","Belki bunu durdurabiliriz.",""]
	if State.currentWorld == 5:
		_text_sequence = ["Bütün teknolojimizi bize karşı   ","kullandılar.","Kazandık mı kaybettik mi.","Bunu bile bilmiyorum.",""]
	if State.currentWorld == 7:
		_text_sequence = ["Hepsini öldürmen gerekecek.",""]
	if State.currentWorld == 8:
		_text_sequence = ["Dikkatli ol.","Saklanarak öldürmeye çalış.",""]
	if State.currentWorld == 9:
		_text_sequence = ["Silahın tepmesiyle daha yükseğe"," çıkabilirsin.",""]
func _display_next_text():
	if _text_number < _text_sequence.size(): 
		_current_text = _text_sequence[_text_number]
		self.text = ""
		_letter_index = 0
		_text_number += 1
		_display_letter()
	else:
		_display_finished = true
		emit_signal("display_finished")

func _display_letter():
	if _letter_index < _current_text.length():
		self.text += _current_text[_letter_index]
		var next_char_wait = _current_text[_letter_index]
		_letter_index += 1
		$"../textsound".play()
		_start_timer_for_char(next_char_wait)
	else:
		_display_next_text()

func _start_timer_for_char(char):
	match char:
		"!", ".", ",", "?":
			timer.start(_punctuation_time)
		" ":
			timer.start(_space_time)
		_:
			timer.start(_letter_time)

func _on_timer_timeout():
	if !_display_finished:
		_display_letter()
