# suma.s del Guión 1
# 1.- añadiéndole convención cdecl
# 2.- añadiéndole printf() y cambiando syscall por exit()
#

#MODULO suma_03_SC_s.s
#suma.s del Guión 1
#1.- añadiéndole convención cdecl
#2.- añadiéndole printf() y cambiando syscall por exit()
#3.- extrayendo suma a módulo C para linkar
 
#gcc -m32 -O1 -g -c suma_03_SC_c.c
#as --32 -g  suma_03_SC_s.s -o suma_03_SC_s.o 
# ld -m elf_i386 suma_03_SC_c.o suma_03_SC_s.o -o suma_03_SC  -lc -dynamic-linker /lib/ld-linux.so.2




# SECCIÓN DE DATOS (.data, variables globales inicializadas)
.section .data
lista:
	.int	1,2,10, 1,2,0b10, 1,2,0x10	# ejemplos binario 0b / hex 0x
longlista:
	.int	(.-lista)/4	# .= contador posiciones. Aritmética de etiquetas.
resultado:
	.int   -1		# 4B a FF para notar cuándo se modifica cada byte
formato:	.ascii "resultado = %d = %0x hex\n\0"

# SECCIÓN DE CÓDIGO (.text, instrucciones máquina)
.section .text
_start:.global _start		# PROGRAMA PRINCIPAL-se puede abreviar de esta forma

	pushl longlista 	#2º arg: número de elementos a sumar
	pushl $lista 		#1er arg: direcció del array lista
	call suma		#llamar suma(&lista, longlista);
	add $8, %esp		#quitar arg. (los dos push que se han hecho arriba)
	mov %eax, resultado

	push %eax		#Version libC de syscall __NR_write
	push %eax		#ventaja: printf() con formato %d %x
	push $formato		#	traduce resultado a ASCII decimal/hex
	call printf		#== printf(formato, resultado, resultado)
	add $12, %esp
	## Versión libC de syscall__NR_exit
	pushl $0		# mov $1, %eax
	call exit		# mov $0, %ebx
	## add $4, %esp (no ret) int $0x80 == exit(0)

# SUBRUTINA:	suma(int* lista, int longlista);
# entrada:	1) %ebx = dirección inicio array
#		2) %ecx = número de elementos a sumar
# salida: 	   %eax = resultado de la suma

suma:
	push %ebp		#Ajuste marco de pila
	mov %esp, %ebp
	
	push %ebx
	mov 8(%ebp), %ebx	#ahora %ebx es calle-save en el cdecl
	mov 12(%ebp), %ecx	#%ecx,%edx no (caller-save)

	mov $0, %eax
	mov $0, %edx
bucle:
	add  (%ebx,%edx,4), %eax	# acumular i-ésimo elemento
	inc      %edx			# incrementar índice
	cmp %edx,%ecx			# comparar con longitud
	jne bucle			# si no iguales, seguir acumulando

	pop %ebx		#Recuperar callee--save
	pop %ebp		#deshacer marco pila
	ret

