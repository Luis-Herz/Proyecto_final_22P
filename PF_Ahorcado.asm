### Proyecto final de Arquitectura de computadoras 22-P - Juego de ahorcado
# Autores:
# 		Luis Enrique Hernandez Hernandez	- 	2153068030
#		Paulina Mendez Flores	- 	2193036709
# Este programa ira pidiendo letras al usuario para poder adivinar una frase ya cargada en memoria,
# se le mostrara al usuario un contador con el numero de fallos que tiene permitidos y la frase en blanco
# con las letras que haya adivinado el usuario.
# El juego termina si el usuario adivina la frase, se rinde o se le acaban los intentos.

.data
	peticion: .asciiz "Escribe una letra: \n"
	intentos: .asciiz "Tienes este numero de intentos: "
	error: .asciiz "Esta letra no pertenece a la frase \n"
	resultado: .asciiz "Esta es la frase: "
	enter: .asciiz "\n"
	frase1: .asciiz "Hola mundo"
	frase2: .space 20 

.text

	#li $v0, 4
	#la $a0, peticion
	#syscall 
	
	la $a0, frase2			# Cargamos la direccion de la frase en $a0, al mismo tiempo la frase del usuario se guardara en frase2
	li $a1, 13				# La frase del usuario solo podra tener 12 letras (Incluidos los espacios)
	li $v0, 8
	syscall
	
	li $v0, 4
	la $a0, enter
	syscall 
	
	li $v0, 4
	la $a0, resultado
	syscall 
	
	li $v0, 4
	la $a0, frase2
	syscall 
	
	li $v0, 10
	syscall 