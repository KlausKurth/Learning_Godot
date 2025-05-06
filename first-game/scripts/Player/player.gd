extends Area2D

# @export permiti ajustar a váriavel pelo inspector
@export var speed = 400 # Quão rápido o player se move em pixels/sec
var screen_size # Tamanho da tela do jogo

func _ready():
	screen_size = get_viewport_rect().size	

func _process(delta):
	var velocity = Vector2.ZERO # movimentação do player
	if Input.is_action_just_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_just_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_just_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_just_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	# Agora que temos uma direção de movimento, podemos atualizar a posição do jogador.
	# Podemos também usar clamp() para impedir que ele saia da tela.
	# Clamp (limitar) um valor significa restringi-lo a um determinado intervalo.
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)	
			
	
					
