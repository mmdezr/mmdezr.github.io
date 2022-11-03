#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <string.h>


#define PROMPT "\nusuario@máquina:~$:"
#define CHARMAX 200 //Un máximo de 200 caracteres por línea.

int segundoplano(char chain[]) {//Esta función tiene el objetivo de buscar el ampersand al final del comando para ejecutar el programa correspondiente en segundo plano.
	int indice2 = 0;

	for (indice2 = 0; indice2 <= strlen(chain); indice2++) {//Recorre la cadena.
		if (chain[indice2] == '&') {//En caso de que se encuentre ampersand
			chain[indice2] = chain[indice2+1]; 
			return(1);}}
			return EXIT_SUCCESS;}

//FUNCIÓN PRINCIPAL.
int main (int argc, char *argv[]) {//Parse command.
	int amper;
	int valor;
	int indice;
	pid_t child_pid;
	pid_t zombiechild_pid;
	char comando[CHARMAX]="";
	char *cadena[CHARMAX];

while(1) {

	// En cada iteración, se reinician las líneas de comando.
	comando[0] = '\0';
	amper = 0;

	printf(PROMPT);//Se muestra el usuario.
	scanf("\n%[^\n]", comando); // Se lee el comando ingresado por el usuario.	
	
	if (strcmp(argv[0],"cd") == 0){ // En caso de que se ingrese "cd".
		if (argv[1] == NULL){
		chdir(getenv("HOME"));}
		else{
		chdir(argv[1]);}
	}
	
	if (strcmp(comando, "exit") == 0){ 
		return(0);} // Si el usuario ingresa "exit", sale de la shell.

	if (segundoplano(comando) == 1){ 
	amper = 1;}

	cadena[0] = strtok(comando, " ");//Primera palabra del comando

	//Siguientes palabras del comando.
	indice=1;
	while((cadena[indice] = strtok(NULL, " ")) != NULL){ 
	indice++;}


	switch (child_pid = fork())
	{
		case -1://Caso error.
			perror("Ha habido un error");//Muestra el mensaje de error.
			exit(-1);//Se detiene la ejecución del proceso.
		case 0://Proceso hijo
			execvp(cadena[0], &cadena[0]);//Se sustituye la imagen del padre por la del hijo.
			perror("Ha habido un error");
			exit(valor);
		default://Proceso padre
			if (amper != 1) {
			zombiechild_pid = 0;
			while ((child_pid != zombiechild_pid) && (zombiechild_pid != -1))
			zombiechild_pid = wait(&valor);}
	}
		}
return EXIT_SUCCESS;}
