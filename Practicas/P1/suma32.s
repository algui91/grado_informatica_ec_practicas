# suma.s:	Sumar los elementos de una lista
#		llamando a función, pasando argumentos mediante registros
# retorna: 	código retorno 0, comprobar suma en %eax mediante gdb/ddd

# SECCIÓN DE DATOS (.data, variables globales inicializadas)
.section .data
lista:
	.int	0x10000000, 0x20000000, 0x40000000, 0x80000000, 0x10000000, 0x20000000, 0x40000000, 0x80000000,0x10000000, 0x20000000, 0x40000000, 0x80000000, 0x10000000, 0x20000000, 0x40000000, 0x80000000, 0x10000000, 0x20000000, 0x40000000, 0x80000000, 0x10000000, 0x20000000, 0x40000000, 0x80000000, 0x10000000, 0x20000000, 0x40000000, 0x80000000, 0x10000000, 0x20000000, 0x40000000, 0x80000000
longlista:
	.int	(.-lista)/4	# .= contador posiciones. Aritmética de etiquetas.
resultado:
	.quad   0		# 4B a FF para notar cuándo se modifica cada byte

##Se usa edx:eax para concatenar el resultado
#adc suma con acarreo
#Se puede usar el if en vez de adc para comprobarlo manualmente.
#Hay instrucciones condicionales que evaluan los flags, salta si hay acarreo.
#Para el segundo programa, con signo, hay que usar cltd, cdq
# SECCIÓN DE CÓDIGO (.text, instrucciones máquina)
.section .text
_start:.global _start		# PROGRAMA PRINCIPAL-se puede abreviar de esta forma

	mov     $lista, %ebx	# dirección del array lista
	mov  longlista, %ecx	# número de elementos a sumar
	call suma		# llamar suma(&lista, longlista);
	mov  %eax,resultado	# salvar resultado
	mov  %esi,resultado+4
	
	#Llamada al sistema WRITE, consultar “man 2 write”
	#		ssize_t  write(int fd, const void *buf, size_t count);
	mov $4, %eax		# write: servicio 4 kernel Linux
	mov $1, %ebx		#    fd: descriptor de fichero para stdout
	mov resultado, %ecx	#   buf: dirección del texto a escribir
	mov $8, %edx		# count: número de bytes a escribir
	int $0x80		# llamar write(stdout, &saludo, longsaludo);	

	# void _exit(int status);
	mov $1, %eax		#   exit: servicio 1 kernel Linux
	mov $0, %ebx	# status: código a retornar (0=OK)
	int $0x80		# llamar _exit(0);

# SUBRUTINA:	suma(int* lista, int longlista);
# entrada:	1) %ebx = dirección inicio array
#		2) %ecx = número de elementos a sumar
# salida: 	   %eax = resultado de la suma

suma:
	push     %edx		# preservar %edx (se usa aquí como índice)
	mov  $0, %eax		# poner a 0 acumulador
	mov  $0, %edx		# poner a 0 índice
	xor  %esi, %esi		# poner a 0 esi
	xor %edi, %edi
bucle:
	add (%ebx, %edx,4), %eax
	adc $0, %esi			# acumular i-ésimo elemento
	inc      %edx			# incrementar índice
	cmp %edx,%ecx			# comparar con longitud
	jne bucle			# si no iguales, seguir acumulando

	pop %edx			# recuperar %edx antiguo
	ret
