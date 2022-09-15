// Proyecto final de Arquitectura de computadoras 22-P - Juego de ahorcado
/* Autores:
 		Luis Enrique Hernandez Hernandez	- 	2153068030
		Paulina Mendez Flores	- 	2193036709
 Este programa ira pidiendo letras al usuario para poder adivinar una frase ya cargada en memoria,
 se le mostrara al usuario un contador con el numero de fallos que tiene permitidos y la frase en blanco
 con las letras que haya adivinado el usuario.
 El juego termina si el usuario adivina la frase, se rinde o se le acaban los intentos.
 */
#include <stdio.h>
#include <string.h>
#define N 15 
char frase [N];
char frase2 [N];

/*
	Esta funcion evaluara si la letra del usuario 2 coincide con alguna
	en la frase dada por el usuario 1.
	Recibe las variables: letra, contador y asiertos.
	Regresara el numero de veces la letra coincidio.
*/
int evaluarLetra(char l, int c, int a){
	if (c < N){					// aqui se evalua si ya se llego al final de la cadena frase
		if (frase[c] == l){		// entra al if si la letra del usuario coincide con una de la frase, en otro caso, nos movemos a la siguiente letra de la frase
			frase2[c] = l;		// Se va llenando la cadena vacia frase2
			a = a + 1;			// a aumenta al encontrar una coincidencia
		}
			c = c+1;			// nos movemos a la siguiente posicion de los arreglos
			a = evaluarLetra(l, c, a);		// llamada recursiva
	}
	
	return a;
}

/*
	Esta funcion recibira las letras dadas por usuario 2
	Aparte mostrara los resultados de cada intento y
	evaluara si aun le quedan intentos a usuario 2.
	No recibe variables.
	No regresa nada, solo mostrara mensajes en pantalla.
*/
void leerLetra(){
	char letra;
	int contador;						// variable con la que nos posicionaremos en el arreglo frase y frase2
	int aciertos;						// variable que indicara el numero de veces que se encontraron coincidencias entre la letra y la frase
	int intentos = 5;					// limite de intentos para adivinar la frase
	int letrasIguales = 0;
	while (intentos > 0){				// mientras usuario 2 aun tenga intentos disponibles podra seguir escribiendo letras
		contador = 0;
		aciertos = 0;
		printf("\nIntentos disponibles: %i", intentos);
		printf("\nEscribe una letra: ");
		scanf("\n%c", &letra);				// escribo \n en el scanf para omitir la pulsacion de la tecla enter
		aciertos = evaluarLetra(letra, contador, aciertos);
		printf("\n %s \n", frase2);			// Se va mostrando el prgreso de lo que ha adivinado el usuario 2
		if (aciertos == 0){					// si la letra no coincidio con ninguna letra en la frase, se reducen los intentos disponibles
			intentos = intentos -1;
		} else if(strcmp(frase, frase2) == 0) {		// strcmp regresa un 0 si frase y frase2 son iguales
			break;									// si ya se encontro la frase, se rompe el bucle
		}
	}	// Fin del while

	if (intentos == 0){
		printf("\nFallaste, la frase era: %s", frase);
	} else {
		printf("\nGanaste, la frase era: %s", frase2);
	}
	return;
}


int main() {
    printf("Ingresa una frase (solo letras mayusculas): ");
	fgets(frase,N, stdin);				// instruccion para leer una cadena de caracteres, incluyendo espacios
    // Remover salto de línea ('\n') de la cadena frase
    if ((strlen(frase) > 0) && (frase[strlen(frase) - 1] == '\n')){
        frase[strlen(frase) - 1] = '\0';
    }
	// Este for copiara la estructura de frase en frase2, pero en lugar de letras pondra giones bajos
	for (int i = 0; i < N-1; i++){
		if (frase[i] != ' '){
			frase2[i] = '_';
		} else{
			frase2[i] = ' ';
		}
		printf("\n");				// Salto de linea que ocultara la frase original al usuario 2
	}
	leerLetra();					// llamada a la funcion que recibira las letras de usuario 2
    return 0;
}
