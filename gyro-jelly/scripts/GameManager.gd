extends Node2D

# --- CONFIGURACIÓN ---
# La fuerza con la que caerán las cosas
var gravity_strength = 980 

func _ready():
	print("GameManager cargado. El juego está listo.")
	# Aseguramos que el input funcione
	set_process_input(true)

func _process(delta):
	# Esta función corre en cada frame del juego
	handle_gravity_input()

func handle_gravity_input():
	var new_gravity_vector = Vector2.ZERO
	
	# Detectamos las flechas del teclado
	if Input.is_action_pressed("ui_up"):    # Flecha Arriba
		new_gravity_vector = Vector2.UP
	elif Input.is_action_pressed("ui_down"):  # Flecha Abajo
		new_gravity_vector = Vector2.DOWN
	elif Input.is_action_pressed("ui_left"):  # Flecha Izquierda
		new_gravity_vector = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"): # Flecha Derecha
		new_gravity_vector = Vector2.RIGHT
	
	# Si se pulsó alguna tecla, cambiamos la gravedad del mundo
	if new_gravity_vector != Vector2.ZERO:
		print("Cambiando gravedad a: ", new_gravity_vector)
		PhysicsServer2D.area_set_param(
			get_viewport().find_world_2d().space, 
			PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, 
			new_gravity_vector
		)