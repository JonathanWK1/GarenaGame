extends Speaker

@export var time_limit = 180

@onready var timer_label = $ColorRect2/TimerLabel
@export var gate_group : GateGroup
var time_count = 0

var freeze = false
var closed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	GlobalSignal.iteration_changed.connect(reset_timer)
	GlobalSignal._arena_finished.connect(freeze_timer)
	time_count = time_limit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!freeze):
		time_count -= delta
		set_timer_label(time_count)
	

func freeze_timer(arena : Node2D):
	if (freeze): return
	if (arena.id == 1):
		freeze = true

func set_timer_label(value):
	timer_label.text = str(int(value))
	if (value <= 0 and not closed):
		gate_group.set_gate_active(true)
		gate_group.is_locked = true
		closed = true

func reset_timer(iteration = 0):
	time_count = time_limit
	gate_group.is_locked = false
	gate_group.set_gate_active(false)
	closed = false
	freeze = false

