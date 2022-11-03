#include <stdio.h>
#include "mi_string.h"
int testeador()
{   //Función de prueba.
    char *texto1, *texto2;
    int intres;
    char *charres;

    texto1 = "mistring";
    printf("Prueba de la función 'strlen' con la cadena 'mistring'.\n");
    intres = mi_strlen(texto1);
    printf("La cadena tiene %d caracteres.\n\n", intres);
    
    printf("Prueba de la función 'strcpy' con las cadenas 'Pepe' como s1 y 'Figueroa' como s2.\n");
    texto1 = "Pepe";
    texto2 = "Figueroa";
    charres = mi_strcpy(texto1, texto2);
    printf("La dirección de memoria de s1 y s2 es: %p y %p, respectivamente.\n", texto1, texto2);
    printf("La copia resultante de %s en %s es: %s\n", texto2, texto1, charres);
    printf("La dirección de memoria de s1 resultante de la sustitución de '%s' por '%s' es: %p\n\n", texto2, texto1, charres);
	
	printf("Prueba de la función 'strcat' con las cadenas 'saca' como s1 y 'corchos' como s2.\n");
    texto1 = "saca";
    texto2 = "corchos";
    charres = mi_strcat(texto1, texto2);
    printf("La dirección de memoria de s1 y s2 es: %p y %p, respectivamente.\n", texto1, texto2);
    printf("La concatenación resultante de %s y %s es: %s\n", texto1, texto2, charres);
    printf("La dirección de memoria de s1 resultante de la concatenación de '%s' y '%s' es: %p\n\n", texto1, texto2, charres);

    printf("Prueba de la función 'strdup' con la cadena 'pepito' como 'str'.\n");
    texto1 = "pepito";
    charres = mi_strdup(texto1);
    printf("La dirección de memoria de str es: %p\n", texto1);
    printf("El duplicado resultante de %s es: %s\n", texto1, charres);
    printf("La dirección de memoria de str resultante de la concatenación de '%s' y '%s' es: %p\n\n", texto1, texto1, charres);
    
    printf("Prueba de la función 'mi_strequals' con las cadenas 'guagua' como s1 y 'guagua' como s2.\n");
    texto1 = "guagua";
    texto2 = "guagua";
    intres = mi_strequals(texto1, texto2);
    printf("¿Son iguales %s y %s?\n 1 -> cadenas idénticas\n 0 -> cadenas diferentes\n Resultado: %d\n", texto2, texto1, intres);
    return 0;
}

int main(){
	testeador();
	return 0;
}
