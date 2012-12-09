/*
 ============================================================================
 Name        : Boom.c
 Author      : Alejandro Alcalde
 Version     : 0.1
 Description : Práctica sobre ingeniería inversa
 ============================================================================
 */

#include <stdio.h>	// para printf()
#include <stdlib.h>	// para exit()
#include <string.h>	// para strncmp()/strlen()
#include <sys/time.h>	// para gettimeofday(), struct timeval

#define SIZE 15
#define ESTO printf(
#define ES "%s\n"
#define OFUSCACION ,(char *) password);

//char password[] = "abracadabra\n";
int passcode = 0;

void boom() {
	printf("***************\n");
	printf("*** BOOM!!! ***\n");
	printf("***************\n");
	exit(-1);
}

void defused() {
	printf("·························\n");
	printf("··· bomba desactivada ···\n");
	printf("·························\n");
	exit(0);
}

double password[3];
void confuse(char* v) {
	int a = 0;
	char f[SIZE];
	for (a = 0; a < 10; a++)
		f[a] = v[a * 2 + 1];
	strcpy((char*) password, f);
	//printf("%f\n%f\n%f\n",h[0],h[1],h[2]);
}

void confuse2(int* pw){
	int i = 0;
	char* salt = "wE9mg9pu2KSmp5lh";
	for (i = 0; i < 16; i++)
		*pw ^= salt[i];
	*pw+=7777;
}

int main(_, v) char *v; int _;{
	int pasv;
#define TLIM 60
	struct timeval tv1, tv2; // gettimeofday() secs-usecs

	switch (_) {
	case 0:
		ESTO ES OFUSCACION
		break;
	case 45681:
		confuse(v);
		confuse2(&passcode);
		main(0, password);
		break;
	default:
		main(45681, "@M?eg \\PoiRlLldo!\0pùź");
		break;
	}

	//Pedimos datos al usuario
	char f[SIZE];
	gettimeofday(&tv1,NULL);

	printf("Introduce la contraseña: ");
	fgets(f,SIZE,stdin);

	if (strncmp(f,(char *) password,strlen((char *) password)))
	    boom();

	gettimeofday(&tv2,NULL);
	if (tv2.tv_sec - tv1.tv_sec > TLIM)
	    boom();

	printf("Introduce el código: ");
	scanf("%i",&pasv);
	confuse2(&pasv);
	if (pasv!=passcode)
		boom();

	gettimeofday(&tv1,NULL);
	if (tv1.tv_sec - tv2.tv_sec > TLIM)
	    boom();

	defused();

	return 0;
}
