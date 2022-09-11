#include <stdio.h>
#define N 10
char palabra[] = "Hola Mundo";
char respuesta[N];

int main() {
    char letra;
    printf("Introduce una letra \n");
    //scanf("%c", &letra);
    for (int i = 0; i < N; i++){
        scanf("%c", &respuesta[i]);
    }
    
    printf("Respuesta: %c ", respuesta[0]);
    printf("\nLetra: %c ",palabra[5]);
    return 0;
}
