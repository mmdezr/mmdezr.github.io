#include <stdlib.h>
#include <stdio.h>
#include "mi_string.h"
int mi_strlen (char* str) {
	int i = 0;
	for(i; str[i] != '\0';i++);//Hasta que no llegue al último carácter de la cadena(/0), la variable "i" no deja de incrementarse.
	return i;//Se devuelve el contador
}

char* mi_strcpy (char* s1, char* s2) {
    int longtotal;
	longtotal = mi_strlen(s1) + mi_strlen(s2);//Se suma la longitud de cada una de las cadenas.
	s1 = (char*)malloc(longtotal);//Se asigna un bloque de memoria de la longitud de las dos cadenas en total.
	int i;
    for(i = 0; i < longtotal; i++){
        s1[i] = s2[i];//Se sustituyen los caracteres de s1 con los de s2.
    }
    s1[mi_strlen(s1)] = '\0';//Se añade el valor NULL al final de la cadena.
    return s1;
    free(s1);//Se libera la memoria asignada por malloc.
}


char* mi_strcat (char* s1, char* s2) {
	int longtotal;
	longtotal = mi_strlen(s1) + mi_strlen(s2);//Se suma la longitud de cada una de las cadenas.
	char* s3 = s1;
	s3 = (char*)malloc(longtotal);//Se asigna un bloque de memoria de la longitud de las dos cadenas en total.
	int i;
    for(i = 0; i < mi_strlen(s1); i++){
        s3[i] = s1[i];//Se añade al vector vacío s1.
    }
     for(i = 0; i < mi_strlen(s2); i++){
        s3[mi_strlen(s1) + i] = s2[i];//Se concatena al vector con s1, s2.
    }
    return s3;
    free(s3);//Se libera la memoria asignada por malloc.
}

char* mi_strdup (char* str) {    
	int longtotal;
	longtotal = 2*mi_strlen(str);//Se multiplica por dos la longitud de la cadena pasada para obtener el número de caracteres de la palabra duplicada.
	char* s3 = str;
	s3 = (char*)malloc(longtotal);//Se asigna un bloque de memoria de la longitud de cadena duplicada.
	int i;
    for(i = 0; i < mi_strlen(str); i++){
    	s3[i] = str[i];    //Primero, como en strcat, se añade al vector vacío los caracteres de la cadena pasada.
    }
    for(i = 0; i < mi_strlen(str); i++){
    	s3[mi_strlen(str)+ i] = str[i];    //Se concatena a la cadena pasada como parámetro esta misma de nuevo, resultado una cadena de una palabra duplicada.
    }
    return s3;
    free(s3);//Se libera la memoria asignada por malloc.
 }
 
int mi_strequals (char* s1, char* s2){
	int i;
	if(mi_strlen(s1) != mi_strlen(s2)){// Si las dos cadenas no miden lo mismo, ya no son idénticas.
		return 0;
	} else { 
		for (i = 0; i < mi_strlen(s1); i++){
			if (s1[i] != s2[i]){//En caso de que midan lo mismo, compara los elementos de la misma posición de cada cadena en cada iteración, y si hay uno distinto a otro, devuelve 0.
				return 0;
			}
		}
		return 1;//Si en todo el bucle no se ha devuelto 0, se devuelve 1, que significa que las cadenas son idénticas.
	}
}
 
 
 
 
