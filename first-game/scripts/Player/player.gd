extends Area2D

signal hit
# @export permiti ajustar a váriavel pelo inspector
@export var speed = 400 # Quão rápido o player se move em pixels/sec
var screen_size # Tamanho da tela do jogo

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func _ready():
	screen_size = get_viewport_rect().size
	hide()	

# para gerar o movimento do player ao pressionar as teclas
func _process(delta):
	var velocity = Vector2.ZERO # movimentação do player
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	# para verificar se o player esta andando ou parado
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	# Para o player espelhar a imagem na direção da corrida
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0	
	
	# Agora que temos uma direção de movimento, podemos atualizar a posição do jogador.
	# Podemos também usar clamp() para impedir que ele saia da tela.
	# Clamp (limitar) um valor significa restringi-lo a um determinado intervalo.
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
		
			
	
					


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	# Cada vez que um inimigo atinge o jogador, o sinal será emitido. 
	# Precisamos desativar a colisão do jogador para que não acione o sinal hit mais de uma vez.
	$CollisionShape2D.set_deferred("disabled", true)
