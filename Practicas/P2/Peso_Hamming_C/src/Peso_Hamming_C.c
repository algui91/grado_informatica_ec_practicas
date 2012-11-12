/*
 ============================================================================
 Name        : Peso_Hamming_C.c
 Author      : Alex
 Version     :
 Copyright   : Your copyright notice
 Description : Hello World in C, Ansi-style
 ============================================================================
 */

//gcc -m32 -O1 -fno-omit-frame-pointer pesoHamming_C.c -o pesoHamming_C
#include <stdio.h>	// para printf()
#include <stdlib.h>	// para exit()
#include <sys/time.h>	// para gettimeofday(), struct timeval
#define WSIZE 8*sizeof(int)
#define SIZE 2//(1<<20)	// tamaño suficiente para tiempo apreciable
unsigned lista[SIZE] = {0x10000000, 0xf0000000};// 0x00000003, 0x00000003};
int resultado = 0;

int hamming1(unsigned* array, int len) {
	int i, k;
	int result = 0;
	for (k = 0; k < len; k++)
		for (i = 0; i < WSIZE; i++) {
			unsigned mask = 1 << i;
			result += (array[k] & mask) != 0;
		}
	return result;
}

int hamming2(unsigned* array, int len) {
	int result = 0;
	int i;
	unsigned x;
	for (i = 0; i < len; i++) {
		x = array[i];
		while (x) {
			result += x & 0x1;
			x >>= 1;
		}
	}
	return result;
}

int hamming3(unsigned* array, int len) {
	int result = 0;
	int i;
	unsigned x;
	for (i = 0; i < len; i++) {
		x = array[i];
		asm("\n"
				"ini3:                             \n\t"
				"shr $0x1, %[x]        \n\t" //Desplazar afecta a CF ZF
				"adc $0x0, %[r]        \n\t"
				"test %[x], %[x]       \n\t"
				"jnz ini3 "

				: [r] "+r" (result)// e/s: inicialmente 0, salida valor final
				: [x] "r" (x) );
	}
	return result;
}

int hamming4(unsigned* array, int len) {
	int val = 0;
	int i, k;

	for (i = 0; i < len; i++) {
		unsigned x = array[i];
		for (k = 0; k < 4; k++) {
			val += x & 0x01010101;
			x >>= 1;
		}
	}
	val += (val >> 32);
	val += (val >> 16);
	val += (val >> 8);
	return val & 0xFFFFFFFF;
}

void crono(int (*func)(), char* msg) {
	struct timeval tv1, tv2; // gettimeofday() secs-usecs
	long tv_usecs; // y sus cuentas

	gettimeofday(&tv1, NULL);
	resultado = func(lista, SIZE);
	gettimeofday(&tv2, NULL);

	tv_usecs = (tv2.tv_sec - tv1.tv_sec) * 1E6 + (tv2.tv_usec - tv1.tv_usec);
	printf("resultado = %d\t", resultado);
	printf("%s:%9ld us\n", msg, tv_usecs);
}

int main() {
	int i; // inicializar array
//	for (i = 0; i < SIZE; i++) // se queda en cache
//		lista[i] = i;

	//crono(hamming1, "Hamming1 (en lenguaje C for)");
	//crono(hamming2, "Hamming2 (en lenguaje C whi)");
	//crono(hamming3, "Hamming3 (Ahorrando máscara)");
	crono(hamming4, "Hamming4 (Sumando bytes completos)");
	//printf("N*(N+1)/2 = %d\n", (SIZE-1)*(SIZE/2)); /*OF*/
	//printf("N*(N+1)/2 = %d\n", sizeof(long));
	exit(0);
}
