# Suma.s del guion 1
# 1.- Añadiendole convención cdecl
#	as --32 -g 	suma_01_S_cdecl.s -o suma_01_S_cdecl.o
#	ld -m elf_i386  suma_01_S_cdecl.o -o suma_01_S_cdecl

# SECCIÓN DE DATOS (.data, variables globales inicializadas)
.section .data
lista:
	.int	1,2,10, 1,2,0b10, 1,2,0x10	# ejemplos binario 0b / hex 0x
longlista:
	.int	(.-lista)/4	# .= contador posiciones. Aritmética de etiquetas.
resultado:
	.int   -1		# 4B a FF para notar cuándo se modifica cada byte

# SECCIÓN DE CÓDIGO (.text, instrucciones máquina)
.section .text
_start:.global _start		# PROGRAMA PRINCIPAL-se puede abreviar de esta forma

	pushl longlista 	#2º arg: número de elementos a sumar
	pushl $lista 		#1er arg: direcció del array lista
	call suma		#llamar suma(&lista, longlista);
	add $8, %esp		#quitar arg. (los dos push que se han hecho arriba)
	mov %eax, resultado
				# void _exit(int status);
	mov $1, %eax		#   exit: servicio 1 kernel Linux
	mov $0, %ebx		# status: código a retornar (0=OK)
	int $0x80		# llamar _exit(0);

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

