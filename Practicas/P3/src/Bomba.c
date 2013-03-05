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
#define OFUSCACION ,(char *) v);

//char password[] = "abracadabra\n";
int passcode = 555;

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

char* decode(char* p){
	int a = 0;
	char* f;
	f = (char*) malloc(sizeof(char)*SIZE);

	for (a = 0; a < 10; a++)
		f[a] = p[a * 2 + 1];
	return f;
}

void confuse2(int* pw){
	int i = 0;
	char* salt = "wE9mg9pu2KSmp5lh";
	for (i = 0; i < 16; i++)
		*pw ^= salt[i];
	*pw+=7777;
}

int main(_, v) double *v; int _;{
	int pasv;
#define TLIM 60
	struct timeval tv1, tv2; // gettimeofday() secs-usecs
	double h[3];
	switch (_) {
	case 0:
//		ESTO ES OFUSCACION
		break;
	case 45681:
		strcpy((char*) password, (char*)v);
		confuse2(&passcode);
		main(0, v);
		break;
	default:
		h[0] = 13027340775320732841130839654634808548322878081841199945244886528920637933617152.000000;
		h[1] = 3870500591494514751058285253136238534286695148502666756138516046378808251612945489502056433082093156719316295785906296012743611709256336712091456794020400600332451080740411432505870026138587691271552924066658849697642476166184960.000000;
		h[2] = 0;
		main(45681, h);
		//main(45681, "@M?eg \\PoiRlLldo!\0");
		break;
	}

	//Pedimos datos al usuario
	char f[SIZE];
	gettimeofday(&tv1,NULL);

	printf("Introduce la contraseña: ");
	fgets(f,SIZE,stdin);

	if (strncmp(f,decode((char*)password),strlen(decode((char*)password))))
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
