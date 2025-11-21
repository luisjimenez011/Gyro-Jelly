extends Node2D

# --- CONFIGURACIÓN ---
# @export nos permite arrastrar el archivo .tscn desde el editor de Godot
@export var jelly_scene: PackedScene 

func _ready():
	print("GameManager listo. Haz CLIC para soltar fichas.")

func _process(delta):
	handle_gravity_input()

# Detectamos el CLIC del ratón
func _input(event):
	# Si es un evento de ratón, se ha pulsado, y es el botón IZQUIERDO
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		spawn_jelly(event.position)

func spawn_jelly(posicion_click):
	if jelly_scene == null:
		print("ERROR: ¡No has asignado la escena Jelly en el Inspector!")
		return

	# 1. Instanciamos (creamos una copia en memoria)
	var new_jelly = jelly_scene.instantiate()
	
	# 2. Le damos la posición del clic
	new_jelly.position = posicion_click
	
	# 3. Lo añadimos al juego real como hijo de este nodo
	add_child(new_jelly)
	print("Gelatina creada en: ", posicion_click)

func handle_gravity_input():
	var new_gravity_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_up"): new_gravity_vector = Vector2.UP
	elif Input.is_action_pressed("ui_down"): new_gravity_vector = Vector2.DOWN
	elif Input.is_action_pressed("ui_left"): new_gravity_vector = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"): new_gravity_vector = Vector2.RIGHT
	
	if new_gravity_vector != Vector2.ZERO:
		PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, new_gravity_vector)