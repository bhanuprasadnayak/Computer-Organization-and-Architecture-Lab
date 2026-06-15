	.file	"matmul.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"usage: %s <N>\n"
.LC3:
	.string	"N must be positive\n"
.LC4:
	.string	"allocation failed for N=%d\n"
.LC10:
	.string	"checksum=%f\n"
.LC11:
	.string	"cycles=%llu\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB6646:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$104, %rsp
	.cfi_def_cfa_offset 160
	cmpl	$1, %edi
	jle	.L61
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movl	%eax, 16(%rsp)
	movq	%rax, %r12
	testl	%eax, %eax
	jle	.L62
	movslq	%eax, %r14
	movl	$8, %esi
	movq	%r14, %rbp
	imulq	%r14, %rbp
	movq	%rbp, %rdi
	call	calloc@PLT
	movq	%rbp, %rdi
	movl	$8, %esi
	movq	%rax, %r15
	movq	%rax, 24(%rsp)
	call	calloc@PLT
	movq	%rbp, %rdi
	movl	$8, %esi
	movq	%rax, %rbx
	call	calloc@PLT
	testq	%r15, %r15
	movq	%rax, %rbp
	sete	%al
	testq	%rbx, %rbx
	sete	%dl
	orb	%dl, %al
	jne	.L6
	testq	%rbp, %rbp
	je	.L6
	movl	%r12d, %r10d
	imull	%r12d, %r10d
	leal	-1(%r10), %ecx
	cmpl	$2, %ecx
	jbe	.L31
	movdqa	.LC6(%rip), %xmm2
	pxor	%xmm7, %xmm7
	movl	%r10d, %edx
	movdqa	.LC0(%rip), %xmm5
	movdqa	%xmm7, %xmm8
	shrl	$2, %edx
	movq	%r15, %rax
	movdqa	.LC5(%rip), %xmm3
	pcmpgtd	%xmm2, %xmm8
	salq	$5, %rdx
	movdqa	.LC7(%rip), %xmm4
	movdqa	%xmm5, %xmm6
	addq	%r15, %rdx
.L8:
	movdqa	%xmm6, %xmm0
	movdqa	%xmm7, %xmm9
	movdqa	%xmm8, %xmm10
	addq	$32, %rax
	pcmpgtd	%xmm0, %xmm9
	pmuludq	%xmm0, %xmm10
	movdqa	%xmm0, %xmm1
	pmuludq	%xmm2, %xmm1
	movdqa	%xmm8, %xmm11
	paddd	%xmm3, %xmm6
	pmuludq	%xmm2, %xmm9
	paddq	%xmm10, %xmm9
	movdqa	%xmm7, %xmm10
	psllq	$32, %xmm9
	paddq	%xmm9, %xmm1
	movdqa	%xmm0, %xmm9
	psrlq	$32, %xmm9
	pcmpgtd	%xmm9, %xmm10
	pmuludq	%xmm9, %xmm11
	pmuludq	%xmm2, %xmm9
	pmuludq	%xmm2, %xmm10
	paddq	%xmm11, %xmm10
	psllq	$32, %xmm10
	paddq	%xmm10, %xmm9
	shufps	$221, %xmm9, %xmm1
	pshufd	$216, %xmm1, %xmm1
	psrad	$3, %xmm1
	movdqa	%xmm1, %xmm9
	pslld	$4, %xmm9
	paddd	%xmm9, %xmm1
	psubd	%xmm1, %xmm0
	paddd	%xmm4, %xmm0
	cvtdq2pd	%xmm0, %xmm1
	pshufd	$238, %xmm0, %xmm0
	movups	%xmm1, -32(%rax)
	cvtdq2pd	%xmm0, %xmm0
	movups	%xmm0, -16(%rax)
	cmpq	%rax, %rdx
	jne	.L8
	movl	%r10d, %esi
	andl	$-4, %esi
	testb	$3, %r10b
	je	.L30
.L7:
	movl	%esi, %eax
	movl	$17, %edi
	pxor	%xmm0, %xmm0
	movq	24(%rsp), %r15
	cltd
	movslq	%esi, %r9
	idivl	%edi
	leal	1(%rsi), %eax
	leaq	0(,%r9,8), %r8
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, (%r15,%r9,8)
	cmpl	%eax, %r10d
	jle	.L10
	cltd
	pxor	%xmm0, %xmm0
	idivl	%edi
	leal	2(%rsi), %eax
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, 8(%r15,%r8)
	cmpl	%eax, %r10d
	jle	.L59
	cltd
	pxor	%xmm0, %xmm0
	movdqa	.LC0(%rip), %xmm5
	movdqa	.LC5(%rip), %xmm3
	idivl	%edi
	movq	24(%rsp), %rax
	movdqa	.LC6(%rip), %xmm2
	movdqa	.LC7(%rip), %xmm4
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, 16(%rax,%r8)
.L30:
	pxor	%xmm6, %xmm6
	movl	%r10d, %edx
	movq	%rbx, %rax
	movsd	.LC9(%rip), %xmm8
	movdqa	%xmm6, %xmm7
	shrl	$2, %edx
	pcmpgtd	%xmm2, %xmm7
	salq	$5, %rdx
	unpcklpd	%xmm8, %xmm8
	addq	%rbx, %rdx
.L13:
	movdqa	%xmm5, %xmm0
	movdqa	%xmm6, %xmm9
	movdqa	%xmm7, %xmm10
	addq	$32, %rax
	pcmpgtd	%xmm0, %xmm9
	pmuludq	%xmm0, %xmm10
	movdqa	%xmm0, %xmm1
	pmuludq	%xmm2, %xmm1
	movdqa	%xmm7, %xmm11
	paddd	%xmm3, %xmm5
	pmuludq	%xmm2, %xmm9
	paddq	%xmm10, %xmm9
	movdqa	%xmm6, %xmm10
	psllq	$32, %xmm9
	paddq	%xmm9, %xmm1
	movdqa	%xmm0, %xmm9
	psrlq	$32, %xmm9
	pcmpgtd	%xmm9, %xmm10
	pmuludq	%xmm9, %xmm11
	pmuludq	%xmm2, %xmm9
	pmuludq	%xmm2, %xmm10
	paddq	%xmm11, %xmm10
	psllq	$32, %xmm10
	paddq	%xmm10, %xmm9
	shufps	$221, %xmm9, %xmm1
	pshufd	$216, %xmm1, %xmm1
	psrad	$3, %xmm1
	movdqa	%xmm1, %xmm9
	pslld	$4, %xmm9
	paddd	%xmm9, %xmm1
	psubd	%xmm1, %xmm0
	paddd	%xmm4, %xmm0
	cvtdq2pd	%xmm0, %xmm1
	mulpd	%xmm8, %xmm1
	pshufd	$238, %xmm0, %xmm0
	cvtdq2pd	%xmm0, %xmm0
	mulpd	%xmm8, %xmm0
	movups	%xmm1, -32(%rax)
	movups	%xmm0, -16(%rax)
	cmpq	%rdx, %rax
	jne	.L13
	movl	%r10d, %ecx
	andl	$-4, %ecx
	testb	$3, %r10b
	je	.L14
	movl	%ecx, %eax
	movl	$17, %esi
	pxor	%xmm0, %xmm0
	movslq	%ecx, %r8
	cltd
	movsd	.LC9(%rip), %xmm1
	leaq	0(,%r8,8), %rdi
	idivl	%esi
	leal	1(%rcx), %eax
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, (%rbx,%r8,8)
	cmpl	%r10d, %eax
	jge	.L14
	cltd
	pxor	%xmm0, %xmm0
	idivl	%esi
	leal	2(%rcx), %eax
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rbx,%rdi)
	cmpl	%r10d, %eax
	jge	.L14
	cltd
	pxor	%xmm0, %xmm0
	idivl	%esi
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, 16(%rbx,%rdi)
.L14:
	rdtsc
	xorl	%r8d, %r8d
	movq	24(%rsp), %rsi
	movl	%r12d, %r11d
	movl	%r8d, 12(%rsp)
	movq	%rax, %r13
	salq	$32, %rdx
	leal	-3(%r11), %r8d
	leal	(%r12,%r12), %eax
	orq	%rdx, %r13
	movl	%r12d, %ecx
	andl	$-2, %r8d
	movl	%r12d, %edi
	movl	%r12d, 40(%rsp)
	movl	%r12d, %r15d
	addl	$3, %r8d
	xorl	%r12d, %r12d
	andl	$1, %r11d
	movl	%eax, 72(%rsp)
	movl	%r12d, 36(%rsp)
	cltq
	shrl	%ecx
	andl	$-2, %edi
	movl	%r8d, 44(%rsp)
	salq	$3, %rax
	salq	$3, %r14
	xorl	%edx, %edx
	movl	%r10d, 76(%rsp)
	salq	$4, %rcx
	movq	%rbp, 80(%rsp)
	movq	%r13, 88(%rsp)
	movl	%r11d, 32(%rsp)
	movq	%rax, 64(%rsp)
	movq	%rbp, %rax
.L15:
	xorl	%r10d, %r10d
	cmpl	$2, 16(%rsp)
	jle	.L26
	movl	44(%rsp), %r9d
	leal	(%rdx,%rdi), %r8d
	movq	%rsi, (%rsp)
	movq	%rbx, %r13
	movslq	%r8d, %r8
	movl	%r15d, 56(%rsp)
	leal	1(%rdx), %r12d
	movl	%r15d, %r10d
	addl	%edx, %r9d
	movq	%rbp, 48(%rsp)
	xorl	%r11d, %r11d
	movl	%r9d, 20(%rsp)
	leaq	0(%rbp,%r8,8), %r9
	movq	24(%rsp), %rbp
	movl	%edx, 60(%rsp)
	movq	%rsi, %rdx
.L18:
	movsd	(%rdx), %xmm1
	movsd	8(%rdx), %xmm3
	movslq	%r10d, %r8
	leaq	(%rbx,%r8,8), %r15
	xorl	%r8d, %r8d
	movapd	%xmm1, %xmm4
	unpcklpd	%xmm3, %xmm3
	unpcklpd	%xmm4, %xmm4
	.p2align 4,,10
	.p2align 3
.L16:
	movupd	0(%r13,%r8), %xmm0
	movupd	(%r15,%r8), %xmm2
	movupd	(%rax,%r8), %xmm6
	mulpd	%xmm4, %xmm0
	mulpd	%xmm3, %xmm2
	addpd	%xmm6, %xmm0
	addpd	%xmm2, %xmm0
	movups	%xmm0, (%rax,%r8)
	addq	$16, %r8
	cmpq	%rcx, %r8
	jne	.L16
	movl	32(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L17
	leal	(%r10,%rdi), %r15d
	movslq	%r12d, %r8
	movslq	%r15d, %r15
	movsd	(%rbx,%r15,8), %xmm0
	mulsd	0(%rbp,%r8,8), %xmm0
	leal	(%r11,%rdi), %r8d
	movslq	%r8d, %r8
	mulsd	(%rbx,%r8,8), %xmm1
	addsd	(%r9), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, (%r9)
.L17:
	movl	72(%rsp), %r15d
	leal	2(%r12), %r8d
	addq	$16, %rdx
	addl	%r15d, %r11d
	addl	%r15d, %r10d
	movq	64(%rsp), %r15
	addq	%r15, %r13
	movl	20(%rsp), %r15d
	cmpl	%r15d, %r8d
	je	.L63
	movl	%r8d, %r12d
	jmp	.L18
.L63:
	movl	36(%rsp), %r9d
	movq	48(%rsp), %rbp
	movl	56(%rsp), %r15d
	movl	60(%rsp), %edx
	leal	1(%r12,%r9), %r10d
.L26:
	movl	16(%rsp), %r13d
	movslq	%r10d, %r12
	movl	32(%rsp), %r9d
	movl	%edi, (%rsp)
	imull	%r13d, %r10d
	movslq	%r10d, %r8
	leaq	(%rbx,%r8,8), %r11
	.p2align 4,,10
	.p2align 3
.L22:
	movsd	(%rsi,%r12,8), %xmm2
	cmpl	$1, %r15d
	je	.L33
	movapd	%xmm2, %xmm1
	xorl	%edi, %edi
	unpcklpd	%xmm1, %xmm1
	.p2align 4,,10
	.p2align 3
.L20:
	movupd	(%r11,%rdi), %xmm0
	movupd	(%rax,%rdi), %xmm5
	mulpd	%xmm1, %xmm0
	addpd	%xmm5, %xmm0
	movups	%xmm0, (%rax,%rdi)
	addq	$16, %rdi
	cmpq	%rdi, %rcx
	jne	.L20
	movl	(%rsp), %edi
	testl	%r9d, %r9d
	je	.L21
.L19:
	leal	(%rdx,%rdi), %r8d
	addl	%r10d, %edi
	movslq	%edi, %rdi
	movslq	%r8d, %r8
	mulsd	(%rbx,%rdi,8), %xmm2
	leaq	0(%rbp,%r8,8), %r8
	movsd	(%r8), %xmm0
	addsd	%xmm2, %xmm0
	movsd	%xmm0, (%r8)
.L21:
	addq	$1, %r12
	addl	%r15d, %r10d
	addq	%r14, %r11
	cmpl	%r12d, %r13d
	jg	.L22
	movl	40(%rsp), %r11d
	addl	$1, 12(%rsp)
	addq	%r14, %rax
	addq	%r14, %rsi
	subl	%r11d, 36(%rsp)
	movl	(%rsp), %edi
	movl	12(%rsp), %r9d
	addl	%r11d, %edx
	cmpl	%r9d, 16(%rsp)
	jne	.L15
	movl	76(%rsp), %r10d
	movq	80(%rsp), %r9
	movq	88(%rsp), %r13
	rdtsc
	movq	%rax, %r12
	salq	$32, %rdx
	orq	%rdx, %r12
	cmpl	$1, %r10d
	je	.L34
	movl	%r10d, %eax
	pxor	%xmm0, %xmm0
	shrl	%eax
	salq	$4, %rax
	addq	%rbp, %rax
.L28:
	addsd	(%r9), %xmm0
	addq	$16, %r9
	addsd	-8(%r9), %xmm0
	cmpq	%rax, %r9
	jne	.L28
	testb	$1, %r10b
	je	.L29
	movl	%r10d, %eax
	andl	$-2, %eax
.L27:
	cltq
	addsd	0(%rbp,%rax,8), %xmm0
.L29:
	leaq	.LC10(%rip), %rsi
	movl	$2, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	movq	%r12, %rdx
	movl	$2, %edi
	xorl	%eax, %eax
	subq	%r13, %rdx
	leaq	.LC11(%rip), %rsi
	call	__printf_chk@PLT
	movq	24(%rsp), %rdi
	call	free@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movq	%rbp, %rdi
	call	free@PLT
	xorl	%eax, %eax
.L1:
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L33:
	.cfi_restore_state
	xorl	%edi, %edi
	jmp	.L19
.L61:
	movq	(%rsi), %rcx
	movq	stderr(%rip), %rdi
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC2(%rip), %rdx
	call	__fprintf_chk@PLT
.L3:
	movl	$1, %eax
	jmp	.L1
.L31:
	xorl	%esi, %esi
	jmp	.L7
.L62:
	movq	stderr(%rip), %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC3(%rip), %rdi
	call	fwrite@PLT
	jmp	.L3
.L59:
	movdqa	.LC0(%rip), %xmm5
	movdqa	.LC5(%rip), %xmm3
	movdqa	.LC6(%rip), %xmm2
	movdqa	.LC7(%rip), %xmm4
	jmp	.L30
.L10:
	cmpl	$2, %ecx
	ja	.L59
	movq	.LC9(%rip), %rax
	movq	%rax, (%rbx)
	jmp	.L14
.L34:
	pxor	%xmm0, %xmm0
	xorl	%eax, %eax
	jmp	.L27
.L6:
	movl	16(%rsp), %ecx
	movq	stderr(%rip), %rdi
	leaq	.LC4(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	24(%rsp), %rdi
	call	free@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L3
	.cfi_endproc
.LFE6646:
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.align 16
.LC5:
	.long	4
	.long	4
	.long	4
	.long	4
	.align 16
.LC6:
	.long	2021161081
	.long	2021161081
	.long	2021161081
	.long	2021161081
	.align 16
.LC7:
	.long	1
	.long	1
	.long	1
	.long	1
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC9:
	.long	0
	.long	1071644672
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
