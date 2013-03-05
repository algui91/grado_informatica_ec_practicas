	.file	"suma_09_Casm.c"
	.text
	.globl	suma1
	.type	suma1, @function
suma1:
.LFB18:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %ecx
	movl	12(%ebp), %eax
	testl	%eax, %eax
	jle	.L4
	movl	%ecx, %edx
	leal	(%ecx,%eax,4), %ecx
	movl	$0, %eax
.L3:
	addl	(%edx), %eax
	addl	$4, %edx
	cmpl	%ecx, %edx
	jne	.L3
	jmp	.L2
.L4:
	movl	$0, %eax
.L2:
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE18:
	.size	suma1, .-suma1
	.globl	suma2
	.type	suma2, @function
suma2:
.LFB19:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	.cfi_offset 3, -12
	movl	8(%ebp), %ebx
	movl	12(%ebp), %ecx
	testl	%ecx, %ecx
	jle	.L10
	movl	$0, %eax
	movl	$0, %edx
.L9:
#APP
# 21 "suma_09_Casm.c" 1
	add (%ebx,%edx,4),%eax	

# 0 "" 2
#NO_APP
	addl	$1, %edx
	cmpl	%ecx, %edx
	jne	.L9
	jmp	.L8
.L10:
	movl	$0, %eax
.L8:
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE19:
	.size	suma2, .-suma2
	.globl	suma3
	.type	suma3, @function
suma3:
.LFB20:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	.cfi_offset 3, -12
#APP
# 31 "suma_09_Casm.c" 1
	mov 8(%ebp), %ebx	
	mov 12(%ebp), %ecx	
				
	mov $0, %eax		
	mov $0, %edx		
bucle:				
	add (%ebx,%edx,4),%eax
	inc       %edx		
	cmp %edx,%ecx		
	jne bucle		

# 0 "" 2
#NO_APP
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE20:
	.size	suma3, .-suma3
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"resultado = %d\t"
.LC2:
	.string	"%s:%9ld us\n"
	.text
	.globl	crono
	.type	crono, @function
crono:
.LFB21:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$52, %esp
	.cfi_offset 3, -12
	movl	$0, 4(%esp)
	leal	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	gettimeofday
	movl	$65536, 4(%esp)
	movl	$lista, (%esp)
	call	*8(%ebp)
	movl	%eax, resultado
	movl	$0, 4(%esp)
	leal	-24(%ebp), %eax
	movl	%eax, (%esp)
	call	gettimeofday
	movl	-24(%ebp), %eax
	subl	-16(%ebp), %eax
	movl	%eax, -28(%ebp)
	fildl	-28(%ebp)
	fmuls	.LC0
	movl	-20(%ebp), %eax
	subl	-12(%ebp), %eax
	movl	%eax, -28(%ebp)
	fildl	-28(%ebp)
	faddp	%st, %st(1)
	fnstcw	-30(%ebp)
	movzwl	-30(%ebp), %eax
	movb	$12, %ah
	movw	%ax, -32(%ebp)
	fldcw	-32(%ebp)
	fistpl	-28(%ebp)
	fldcw	-30(%ebp)
	movl	-28(%ebp), %ebx
	movl	resultado, %eax
	movl	%eax, 4(%esp)
	movl	$.LC1, (%esp)
	call	printf
	movl	%ebx, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC2, (%esp)
	call	printf
	addl	$52, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE21:
	.size	crono, .-crono
	.section	.rodata.str1.1
.LC4:
	.string	"suma1 (en lenguaje C    )"
.LC5:
	.string	"suma2 (1 instrucci\303\263n asm)"
.LC6:
	.string	"suma3 (bloque asm entero)"
.LC7:
	.string	"N*(N+1)/2 = %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB22:
	.cfi_startproc
	movl	$0, %eax
.L18:
	movl	%eax, lista(,%eax,4)
	addl	$1, %eax
	cmpl	$65536, %eax
	jne	.L18
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$16, %esp
	movl	$.LC4, 4(%esp)
	movl	$suma1, (%esp)
	call	crono
	movl	$.LC5, 4(%esp)
	movl	$suma2, (%esp)
	call	crono
	movl	$.LC6, 4(%esp)
	movl	$suma3, (%esp)
	call	crono
	movl	$2147450880, 4(%esp)
	movl	$.LC7, (%esp)
	call	printf
	movl	$0, (%esp)
	call	exit
	.cfi_endproc
.LFE22:
	.size	main, .-main
	.globl	resultado
	.bss
	.align 4
	.type	resultado, @object
	.size	resultado, 4
resultado:
	.zero	4
	.comm	lista,262144,32
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC0:
	.long	1232348160
	.ident	"GCC: (Debian 4.7.1-7) 4.7.1"
	.section	.note.GNU-stack,"",@progbits
