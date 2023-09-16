#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/wait.h>

#define CADENA 100

/* ---- PROTOTIPO FUNCIONES ---- */
int returnError(int);
int creaRama(pid_t, char *[], int, int, int);
int tiraBolo(pid_t, pid_t, int, int);
int recibeYBloqueaSennal();

void dibujaArbol(bool, bool, bool, int, int);
void caeBoloEncadenado(int, char *, char *, char *, char, char, char);
char caeBoloSimple(bool, char);

void imprimeTitulo();
void noNada();

/* ---- INICIO PROGRAMA ---- */
int main(int argc, char *argv[]) {
    pid_t pidA, pidB, pidC, pidD, pidE, pidF, pidG, pidH, pidI, pidJ, pidFinal;
    int status, sennal, retorno, cantidadCaeB, cantidadCaeC;
    char inicio[CADENA], pid1[CADENA], pid2[CADENA];
    bool caeE = false, caeI = false, caeH = false;

	if (!strcmp(argv[0], "A")) {
		pidH = fork();
		switch(pidH) {
			case -1: return returnError(0);
			case 0:
				execl(argv[1], "H", argv[1], NULL);
				break;

			default:
				pidI = fork();
				switch(pidI) {
					case -1: return returnError(0);
					case 0:
						execl(argv[1], "I", argv[1], NULL);
						break;

					default:
						pidE = fork();
						switch(pidE) {
							case -1: return returnError(0);
							case 0:
								sprintf(pid1, "%d", pidH);
								sprintf(pid2, "%d", pidI);
								execl(argv[1], "E", argv[1], pid1, pid2, NULL);
								break;
							
							default:
								pidC = fork();
								switch(pidC) {
									case -1: return returnError(0);
									case 0:
										sprintf(pid1, "%d", pidE);
										sprintf(pid2, "%d", pidI);
										execl(argv[1], "C", argv[1], pid1, pid2, NULL);
										break;

									default:
										pidB = fork();
										switch(pidB) {
											case -1: return returnError(0);
											case 0:
												sprintf(pid1, "%d", pidE);
												sprintf(pid2, "%d", pidH);
												execl(argv[1], "B", argv[1], pid1, pid2, NULL);
												break;

											default:
												sennal = recibeYBloqueaSennal();
												if (sennal == -1) return returnError(1);
			
												struct timeval time;
												gettimeofday(&time, NULL);
												int wPid, microsegundos = time.tv_usec, restoMicrosegundos = microsegundos % 4;

												if(restoMicrosegundos == 1) {			// Tira bolo izquierda
													kill(pidB, SIGTERM);
													wPid = waitpid(pidB, &cantidadCaeB, 0);
												} else if(restoMicrosegundos == 2) {	// Tira bolo derecha
													kill(pidC, SIGTERM);
													wPid = waitpid(pidC, &cantidadCaeC, 0);	
												} else if(restoMicrosegundos == 3) { 	// Tira ambos bolos
													kill(pidB, SIGTERM);
													kill(pidC, SIGTERM);
													wPid = waitpid(pidB, &cantidadCaeB, 0);
													wPid = waitpid(pidC, &cantidadCaeC, 0);
												}										// En cualquier otro caso no tira ningún bolo

												sleep(4); // Espera 4 segundos

												if(waitpid(pidH, &retorno, WNOHANG) == pidH) caeH = true;
												if(waitpid(pidE, &retorno, WNOHANG) == pidE) caeE = true;
												if(waitpid(pidI, &retorno, WNOHANG) == pidI) caeI = true;
												

												dibujaArbol(caeE, caeI, caeH, WEXITSTATUS(cantidadCaeB), WEXITSTATUS(cantidadCaeC));

												pidFinal = fork();
												switch(pidFinal) {
													case -1: return returnError(0);
													case 0: execl("/bin/ps", "ps", "-f", NULL);
													default: wPid = waitpid(pidFinal, &status, 0);
												}
												kill(0, SIGINT); // Envia señal para matar todos los procesos
												return 0;
										}
								}
						}
				}
		}
	}
	
	if (!strcmp(argv[0], "B")) return creaRama(pidD, argv, 0, sennal, status);
	if (!strcmp(argv[0], "C")) return creaRama(pidF, argv, 1, sennal, status);
	if (!strcmp(argv[0], "D")) return creaRama(pidG, argv, 2, sennal, status);
	if (!strcmp(argv[0], "F")) return creaRama(pidJ, argv, 3, sennal, status);

	if (!strcmp(argv[0], "E") || !strcmp(argv[0], "G") || !strcmp(argv[0], "H") || !strcmp(argv[0], "I") || !strcmp(argv[0], "J")) {	
        sennal = recibeYBloqueaSennal();	
		if (sennal == -1) return returnError(1);

		if (!strcmp(argv[0], "E")) { // Solo E puede tirar algún bolo como H o I
			pidH = atoi(argv[2]);
			pidI = atoi(argv[3]);
			return tiraBolo(pidH, pidI, status, 4);
		} else return 0;
    }

    pidA = fork();
    switch(pidA) {
        case -1: return returnError(0); // Error
        case 0:     // Código del hijo
            execl(argv[0], "A", argv[0], NULL);
            break;
        default:    // Código del padre
            system("clear");
            imprimeTitulo();
			sprintf(inicio, "\n\nTire la bola escribiendo: 'kill %d'\n\n", getpid()+1);	// Utilizamos kill para enviar un SIGTERM y getpid()+1 nos devuelve el pid de A
            write(1, inicio, strlen(inicio));
            break;
    }

	return 0;
}

/* ---- SEÑALES ---- */
int returnError(int i) { // Se podría enviar otro parámetro para saber en que fork o recibeYBloqueaSennal ha fallado
	char informacion[CADENA];
	if (i == 0) sprintf(informacion, "ERROR: fork.");
	else if (i == 1) sprintf(informacion, "ERROR: recibeYBloqueSennal().");
	perror(informacion);
	return -1;
}

int creaRama(pid_t pid1, char *argv[], int i, int sennal, int status) {
	pid1 = fork();
	switch(pid1) {
		case -1: return returnError(0);
		case 0:
			if (i == 0) execl(argv[1], "D", argv[1], argv[3], NULL);
			else if (i == 1) execl(argv[1], "F", argv[1], argv[3], NULL);
			else if (i == 2) execl(argv[1], "G", argv[1], NULL);
			else if (i == 3) execl(argv[1], "J", argv[1], NULL);
			break;
		
		default:
			sennal = recibeYBloqueaSennal();
			if (sennal == -1) return returnError(1);
			
			pid_t pid2 = atoi(argv[2]);
			return tiraBolo(pid1, pid2, status, i);
	}
	return 0;
}

int tiraBolo(pid_t pid1, pid_t pid2, int status, int i) {
    struct timeval time;
	gettimeofday(&time, NULL);
	int microsegundos = time.tv_usec, restoMicrosegundos = microsegundos % 4;

	if (i == 1 || i == 2) {
		if (restoMicrosegundos == 1) {           // Tira bolo derecha
			kill(pid2, SIGTERM);    
			return 0;
		} else if (restoMicrosegundos == 2) {    // Tira bolo izquierda
			kill(pid1, SIGTERM);
			int pid = waitpid(pid1, &status, 0);
			return WEXITSTATUS(status)+1;
		} else if (restoMicrosegundos == 3) {    // Tira ambos bolos
			kill(pid1, SIGTERM);
			kill(pid2, SIGTERM);
			int pid = waitpid(pid1, &status, 0);
			return WEXITSTATUS(status)+1;
		} else return 0;						 // No tira ninguno

	} else if (i == 0 || i == 3) {
		if (restoMicrosegundos == 1) {           // Tira bolo derecha
			kill(pid1, SIGTERM);    
			int pid = waitpid(pid1, &status, 0);
			return WEXITSTATUS(status)+1;
		} else if (restoMicrosegundos == 2) {    // Tira bolo izquierda
			kill(pid2, SIGTERM);
			return 0;
		} else if (restoMicrosegundos == 3) {    // Tira ambos bolos
			kill(pid1, SIGTERM);
			kill(pid2, SIGTERM);
			int pid = waitpid(pid1, &status, 0);
			return WEXITSTATUS(status)+1;
		} else return 0;						 // No tira ninguno

	} else if (i == 4) {
		if (restoMicrosegundos == 1) {           // Tira bolo derecha
			kill(pid1, SIGTERM);    
			return 1;
		} else if (restoMicrosegundos == 2) {    // Tira bolo izquierda
			kill(pid2, SIGTERM);
			return 1;
		} else if (restoMicrosegundos == 3) {    // Tira ambos bolos
			kill(pid2, SIGTERM);
			kill(pid1, SIGTERM);
			return 1;
		} else return 0;						 // No tira ninguno
	}

	return -1;
}

int recibeYBloqueaSennal() {
	sigset_t conjuntoVacio, conjuntoConSIGTERM, conjuntoAntiguo, conjuntoSinSIGTERM;
    struct sigaction nueva, antigua;

	sigemptyset(&conjuntoConSIGTERM);
	sigaddset(&conjuntoConSIGTERM, SIGTERM);

	if (sigprocmask(SIG_BLOCK, &conjuntoConSIGTERM, &conjuntoAntiguo) == -1) return -1;
 
	conjuntoSinSIGTERM = conjuntoAntiguo;

	sigdelset(&conjuntoSinSIGTERM, SIGTERM);
	sigemptyset(&conjuntoVacio);

	nueva.sa_handler = noNada;
  	nueva.sa_mask = conjuntoVacio;
 	nueva.sa_flags = 0;

	if (sigaction(SIGTERM, &nueva, &antigua) == -1) return -1;
	sigsuspend(&conjuntoSinSIGTERM);

    return 0;
}

/* ---- MOSTRAR RESULTADO POR PANTALLA ---- */
void dibujaArbol(bool caeE, bool caeI, bool caeH, int cantidadCaeB, int cantidadCaeC) {
	char arbol[CADENA],
		 A = '*', B, C, D, E, F, G, H, I, J;

	caeBoloEncadenado(cantidadCaeB, &B, &D, &G, 'B', 'D', 'G');
	caeBoloEncadenado(cantidadCaeC, &C, &F, &J, 'C', 'F', 'J');

	E = caeBoloSimple(caeE, 'E');
	I = caeBoloSimple(caeI, 'I');
	H = caeBoloSimple(caeH, 'H');
	
	sprintf(arbol,
			"\n\n\t\t\t%c\n\n\t\t%c\t\t%c\n\n\t%c\t\t%c\t\t%c\n\n%c\t\t%c\t\t%c\t\t%c\n\n\n",
			A, B, C, D, E, F, G, H, I, J);
	write(1, arbol, strlen(arbol));
}

void caeBoloEncadenado(int cantidad, char *letra1, char *letra2, char *letra3, char valor1, char valor2, char valor3) {
	*letra1 = valor1; *letra2 = valor2; *letra3 = valor3;	// Asignamos las letras y caso en el que no cae ninguno

    if (cantidad == 0) {		// Cae el primer bolo
		*letra1 = '*'; 
	} else if (cantidad == 1) {	// Caen 2 bolos
		*letra1 = '*'; *letra2 = '*'; 
	} else if (cantidad == 2) {	// Caen 3 bolos
		*letra1 = '*'; *letra2 = '*'; *letra3 = '*';
	}
}

char caeBoloSimple(bool cae, char letra) {
	return (cae) ? '*' : letra;
}

/* ---- FUNCIONES EXTRAS ---- */
void imprimeTitulo() {
	puts("██████   ██████  ██       ██████  ███████     ██████");
	puts("██   ██ ██    ██ ██      ██    ██ ██         ██     ");
	puts("██████  ██    ██ ██      ██    ██ ███████    ██     ");
	puts("██   ██ ██    ██ ██      ██    ██      ██    ██     ");
	puts("██████   ██████  ███████  ██████  ███████ ██  ██████");
}

void noNada() {}