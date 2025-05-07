extends RigidBody2D


func _ready():
	# Lista os nomes das animações do AnimatedSprite2D retorna um array contendo neste caso
	# as três animações existentes ["walk", "swim", "fly"]
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	# sorteia e seleciona aleatóriamente uma animação do array listado em mob_types 	
	$AnimatedSprite2D.animation = mob_types.pick_random()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	# Deleta o node em questão após o final do frame da animação
	queue_free()
