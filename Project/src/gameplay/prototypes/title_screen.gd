class_name TitleScreen extends Control
signal start_game
signal close_game

@onready var main_menu: Control = $MainMenuContainter
@onready var options: Control = $OptionsContainer
@onready var credits: Control = $CreditsContainer

enum MENU_STATES {
	MAIN,
	OPTIONS,
	CREDITS
}

var off_screen: Vector2 = Vector2(-320, 0)
var on_screen: Vector2  = Vector2(0, 0)
var current_screen: Control 
var tween: Tween
@export var trans_time: float = 1.0
@export var ease_type: Tween.EaseType
@export var trans_type: Tween.TransitionType
@onready var effectee: TextureRect = $TextureRect


func reset_tween():
	if tween:
		tween.kill()
	tween = get_tree().create_tween().set_ease(ease_type).set_trans(trans_type).set_parallel(true)

func swap_to_menu_screen(to_screen: MENU_STATES): 
	var to_menu: Control
	match to_screen:
		MENU_STATES.MAIN:
			to_menu = main_menu
		MENU_STATES.OPTIONS:
			to_menu = options
		MENU_STATES.CREDITS:
			to_menu = credits
	
	if to_menu == current_screen:
		return
	
	if current_screen != null:
		current_screen.visible = false
		
		#reset_tween()
		#tween.tween_property(current_screen, "position", off_screen, trans_time)
		#await tween.finished
	
	#ended up ugly, reutilize for a transition in the future
	#reset_tween()
	#tween.tween_property(to_move, "position", on_screen, trans_time)
	#await tween.finished
	
	to_menu.visible = true
	current_screen = to_menu

func emit_start_game():
	start_game.emit()

##close da game
func exit_game():
	close_game.emit()


@warning_ignore("unused_parameter")
func _on_start_button_detec_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_start_game()

@warning_ignore("unused_parameter")
func _on_option_button_detec_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			swap_to_menu_screen(MENU_STATES.OPTIONS)


@warning_ignore("unused_parameter")
func _on_exit_button_detec_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			exit_game()


func _on_credits_button_detec_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			swap_to_menu_screen(MENU_STATES.CREDITS)


func _on_back_to_menu_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			swap_to_menu_screen(MENU_STATES.MAIN)
