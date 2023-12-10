extends AudioStreamPlayer


func _ready() -> void:
	GlobalSignal.play_audio.connect(
		func(audio: AudioStream) -> void:
			stream = audio
			play()
	)
