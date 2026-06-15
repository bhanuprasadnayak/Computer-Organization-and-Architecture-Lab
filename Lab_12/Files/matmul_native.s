	.file	"matmul.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"usage: %s <N>\n"
.LC3:
	.string	"N must be positive\n"
.LC4:
	.string	"allocation failed for N=%d\n"
.LC14:
	.string	"checksum=%f\n"
.LC15:
	.string	"cycles=%llu\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB6646:
	.cfi_startproc
	endbr64
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	pushq	%rbx
	subq	$160, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	cmpl	$1, %edi
	jle	.L81
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	testl	%eax, %eax
	movl	%eax, -60(%rbp)
	movq	%rax, %r13
	jle	.L82
	movslq	%eax, %r12
	movl	$8, %esi
	movq	%r12, -72(%rbp)
	imulq	%r12, %r12
	movq	%r12, %rdi
	call	calloc@PLT
	movq	%r12, %rdi
	movl	$8, %esi
	movq	%rax, %r14
	movq	%rax, -112(%rbp)
	call	calloc@PLT
	movq	%r12, %rdi
	movl	$8, %esi
	movq	%rax, %rbx
	call	calloc@PLT
	testq	%r14, %r14
	movq	%rax, %r12
	sete	%al
	testq	%rbx, %rbx
	sete	%dl
	orb	%dl, %al
	jne	.L6
	testq	%r12, %r12
	je	.L6
	movl	%r13d, %r9d
	vxorps	%xmm2, %xmm2, %xmm2
	imull	%r13d, %r9d
	leal	-1(%r9), %r10d
	cmpl	$6, %r10d
	jbe	.L39
	movl	$8, %ecx
	movl	%r9d, %edx
	vmovdqa	.LC0(%rip), %ymm3
	movq	%r14, %rax
	vmovd	%ecx, %xmm7
	movl	$2021161081, %ecx
	shrl	$3, %edx
	vmovd	%ecx, %xmm5
	movl	$1, %ecx
	salq	$6, %rdx
	vmovdqa	%ymm3, %ymm4
	vmovd	%ecx, %xmm6
	addq	%r14, %rdx
	vpbroadcastd	%xmm7, %ymm7
	vpbroadcastd	%xmm5, %ymm5
	vpbroadcastd	%xmm6, %ymm6
.L8:
	vmovdqa	%ymm4, %ymm0
	addq	$64, %rax
	vpaddd	%ymm7, %ymm4, %ymm4
	vpmuldq	%ymm5, %ymm0, %ymm1
	vpsrlq	$32, %ymm0, %ymm8
	vpmuldq	%ymm5, %ymm8, %ymm8
	vpshufd	$245, %ymm1, %ymm1
	vpblendd	$170, %ymm8, %ymm1, %ymm1
	vpsrad	$3, %ymm1, %ymm1
	vpslld	$4, %ymm1, %ymm8
	vpaddd	%ymm1, %ymm8, %ymm1
	vpsubd	%ymm1, %ymm0, %ymm0
	vpaddd	%ymm6, %ymm0, %ymm0
	vcvtdq2pd	%xmm0, %ymm1
	vextracti128	$0x1, %ymm0, %xmm0
	vmovupd	%ymm1, -64(%rax)
	vcvtdq2pd	%xmm0, %ymm0
	vmovupd	%ymm0, -32(%rax)
	cmpq	%rdx, %rax
	jne	.L8
	movl	%r9d, %ecx
	andl	$-8, %ecx
	cmpl	%ecx, %r9d
	movl	%ecx, %eax
	je	.L9
.L7:
	movl	%r9d, %edx
	subl	%eax, %edx
	leal	-1(%rdx), %esi
	cmpl	$2, %esi
	jbe	.L10
	movq	-112(%rbp), %rdi
	vmovd	%ecx, %xmm5
	vpshufd	$0, %xmm5, %xmm0
	vpaddd	.LC5(%rip), %xmm0, %xmm0
	leaq	(%rdi,%rax,8), %rax
	movl	$2021161081, %edi
	vmovd	%edi, %xmm3
	vpsrlq	$32, %xmm0, %xmm4
	movl	$1, %edi
	vpshufd	$0, %xmm3, %xmm3
	vpmuldq	%xmm3, %xmm0, %xmm1
	vpmuldq	%xmm3, %xmm4, %xmm3
	vpshufd	$245, %xmm1, %xmm1
	vpblendd	$10, %xmm3, %xmm1, %xmm1
	vpsrad	$3, %xmm1, %xmm1
	vpslld	$4, %xmm1, %xmm3
	vpaddd	%xmm1, %xmm3, %xmm1
	vpsubd	%xmm1, %xmm0, %xmm0
	vmovd	%edi, %xmm1
	vpshufd	$0, %xmm1, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	vcvtdq2pd	%xmm0, %xmm1
	vpshufd	$238, %xmm0, %xmm0
	vmovupd	%xmm1, (%rax)
	vcvtdq2pd	%xmm0, %xmm0
	vmovupd	%xmm0, 16(%rax)
	movl	%edx, %eax
	andl	$-4, %eax
	addl	%eax, %ecx
	andl	$3, %edx
	je	.L11
.L10:
	movl	%ecx, %eax
	movl	$17, %edi
	movq	-112(%rbp), %r14
	movslq	%ecx, %r8
	cltd
	leaq	0(,%r8,8), %rsi
	idivl	%edi
	leal	1(%rcx), %eax
	addl	$1, %edx
	cmpl	%eax, %r9d
	vcvtsi2sdl	%edx, %xmm2, %xmm0
	vmovsd	%xmm0, (%r14,%r8,8)
	jle	.L11
	cltd
	idivl	%edi
	leal	2(%rcx), %eax
	addl	$1, %edx
	cmpl	%eax, %r9d
	vcvtsi2sdl	%edx, %xmm2, %xmm0
	vmovsd	%xmm0, 8(%r14,%rsi)
	jle	.L11
	cltd
	idivl	%edi
	addl	$1, %edx
	vcvtsi2sdl	%edx, %xmm2, %xmm0
	vmovsd	%xmm0, 16(%r14,%rsi)
.L11:
	cmpl	$6, %r10d
	jbe	.L40
	vmovdqa	.LC0(%rip), %ymm3
.L9:
	movl	$8, %ecx
	movl	%r9d, %edx
	movq	%rbx, %rax
	vbroadcastsd	.LC12(%rip), %ymm5
	vmovd	%ecx, %xmm7
	movl	$2021161081, %ecx
	shrl	$3, %edx
	vmovd	%ecx, %xmm4
	movl	$1, %ecx
	salq	$6, %rdx
	vpbroadcastd	%xmm7, %ymm7
	vmovd	%ecx, %xmm6
	addq	%rbx, %rdx
	vpbroadcastd	%xmm4, %ymm4
	vpbroadcastd	%xmm6, %ymm6
.L14:
	vmovdqa	%ymm3, %ymm0
	addq	$64, %rax
	vpaddd	%ymm7, %ymm3, %ymm3
	vpmuldq	%ymm4, %ymm0, %ymm1
	vpsrlq	$32, %ymm0, %ymm8
	vpmuldq	%ymm4, %ymm8, %ymm8
	vpshufd	$245, %ymm1, %ymm1
	vpblendd	$170, %ymm8, %ymm1, %ymm1
	vpsrad	$3, %ymm1, %ymm1
	vpslld	$4, %ymm1, %ymm8
	vpaddd	%ymm1, %ymm8, %ymm1
	vpsubd	%ymm1, %ymm0, %ymm0
	vpaddd	%ymm6, %ymm0, %ymm0
	vcvtdq2pd	%xmm0, %ymm1
	vmulpd	%ymm5, %ymm1, %ymm1
	vextracti128	$0x1, %ymm0, %xmm0
	vcvtdq2pd	%xmm0, %ymm0
	vmulpd	%ymm5, %ymm0, %ymm0
	vmovupd	%ymm1, -64(%rax)
	vmovupd	%ymm0, -32(%rax)
	cmpq	%rax, %rdx
	jne	.L14
	movl	%r9d, %ecx
	andl	$-8, %ecx
	cmpl	%r9d, %ecx
	movl	%ecx, %eax
	je	.L15
.L13:
	movl	%r9d, %edx
	subl	%eax, %edx
	leal	-1(%rdx), %esi
	cmpl	$2, %esi
	jbe	.L16
	vmovd	%ecx, %xmm5
	movl	$2021161081, %edi
	movl	$1, %esi
	vpshufd	$0, %xmm5, %xmm0
	vmovd	%edi, %xmm3
	leaq	(%rbx,%rax,8), %rax
	vpaddd	.LC5(%rip), %xmm0, %xmm0
	vpshufd	$0, %xmm3, %xmm3
	vpmuldq	%xmm3, %xmm0, %xmm1
	vpsrlq	$32, %xmm0, %xmm4
	vpmuldq	%xmm3, %xmm4, %xmm3
	vpshufd	$245, %xmm1, %xmm1
	vpblendd	$10, %xmm3, %xmm1, %xmm1
	vpsrad	$3, %xmm1, %xmm1
	vpslld	$4, %xmm1, %xmm3
	vpaddd	%xmm1, %xmm3, %xmm1
	vmovddup	.LC12(%rip), %xmm3
	vpsubd	%xmm1, %xmm0, %xmm0
	vmovd	%esi, %xmm1
	vpshufd	$0, %xmm1, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	vcvtdq2pd	%xmm0, %xmm1
	vmulpd	%xmm3, %xmm1, %xmm1
	vpshufd	$238, %xmm0, %xmm0
	vcvtdq2pd	%xmm0, %xmm0
	vmulpd	%xmm3, %xmm0, %xmm0
	vmovupd	%xmm1, (%rax)
	vmovupd	%xmm0, 16(%rax)
	movl	%edx, %eax
	andl	$-4, %eax
	addl	%eax, %ecx
	andl	$3, %edx
	je	.L15
.L16:
	movl	%ecx, %eax
	movl	$17, %edi
	vmovsd	.LC12(%rip), %xmm1
	movslq	%ecx, %r8
	cltd
	leaq	0(,%r8,8), %rsi
	idivl	%edi
	leal	1(%rcx), %eax
	addl	$1, %edx
	cmpl	%eax, %r9d
	vcvtsi2sdl	%edx, %xmm2, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
	vmovsd	%xmm0, (%rbx,%r8,8)
	jle	.L15
	cltd
	idivl	%edi
	leal	2(%rcx), %eax
	addl	$1, %edx
	cmpl	%r9d, %eax
	vcvtsi2sdl	%edx, %xmm2, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
	vmovsd	%xmm0, 8(%rbx,%rsi)
	jge	.L15
	cltd
	idivl	%edi
	addl	$1, %edx
	vcvtsi2sdl	%edx, %xmm2, %xmm2
	vmulsd	%xmm1, %xmm2, %xmm0
	vmovsd	%xmm0, 16(%rbx,%rsi)
.L15:
	rdtsc
	xorl	%r8d, %r8d
	xorl	%r14d, %r14d
	movq	-112(%rbp), %rcx
	movq	%rax, %r15
	movq	-72(%rbp), %rax
	movl	%r13d, %r11d
	movq	%rcx, -56(%rbp)
	leal	-3(%r11), %edi
	salq	$32, %rdx
	movq	%r12, -96(%rbp)
	salq	$3, %rax
	andl	$-2, %edi
	orq	%rdx, %r15
	movl	%r9d, -164(%rbp)
	movq	%rax, -88(%rbp)
	leal	(%r13,%r13), %eax
	addl	$3, %edi
	movl	%r13d, %edx
	movslq	%eax, %rcx
	movl	%edi, -124(%rbp)
	movl	%r11d, %edi
	andl	$3, %r11d
	movl	%eax, -148(%rbp)
	movl	%r13d, %eax
	movq	-88(%rbp), %rsi
	shrl	$2, %eax
	movq	%rcx, -160(%rbp)
	leal	-1(%r13), %ecx
	salq	$5, %rax
	movl	%ecx, -64(%rbp)
	movq	%rax, %rcx
	movl	%r13d, %eax
	movl	%r11d, -76(%rbp)
	xorl	%r13d, %r13d
	andl	$-4, %eax
	movq	%r12, -176(%rbp)
	movq	%r15, -184(%rbp)
	subl	%eax, %edi
	movl	%eax, -80(%rbp)
	movq	%r12, %rax
	movl	%r13d, -120(%rbp)
	xorl	%r13d, %r13d
	movl	%edi, -152(%rbp)
	movl	%r8d, %edi
	movl	%r10d, -168(%rbp)
	movl	%edx, %r10d
.L18:
	xorl	%r8d, %r8d
	cmpl	$2, -60(%rbp)
	jle	.L35
	leal	1(%r13), %r15d
	movl	%edx, -132(%rbp)
	movl	%edx, %r8d
	xorl	%r9d, %r9d
	movl	%r15d, -88(%rbp)
	movl	-124(%rbp), %r15d
	movl	%r10d, -136(%rbp)
	movq	-112(%rbp), %r10
	addl	%r13d, %r15d
	movl	%edi, -128(%rbp)
	movl	%r15d, -104(%rbp)
	movq	-56(%rbp), %r15
	movq	%rsi, -144(%rbp)
	movq	%r15, -96(%rbp)
	movq	-96(%rbp), %rdx
	xorl	%r15d, %r15d
	cmpl	$2, -64(%rbp)
	vmovsd	(%rdx), %xmm0
	jbe	.L83
.L77:
	movslq	%r8d, %rdi
	vbroadcastsd	8(%rdx), %ymm2
	leaq	(%rbx,%r15,8), %r11
	xorl	%edx, %edx
	vbroadcastsd	%xmm0, %ymm3
	leaq	(%rbx,%rdi,8), %rsi
	.p2align 4,,10
	.p2align 3
.L19:
	vmovupd	(%r11,%rdx), %ymm1
	vfmadd213pd	(%rax,%rdx), %ymm3, %ymm1
	vfmadd231pd	(%rsi,%rdx), %ymm2, %ymm1
	vmovupd	%ymm1, (%rax,%rdx)
	addq	$32, %rdx
	cmpq	%rcx, %rdx
	jne	.L19
	movl	-76(%rbp), %r11d
	testl	%r11d, %r11d
	je	.L20
	movl	-152(%rbp), %esi
	cmpl	$1, %esi
	movl	%esi, %edx
	je	.L41
	movl	-80(%rbp), %r11d
	movl	%r11d, -116(%rbp)
	movl	%r11d, %esi
.L31:
	leaq	(%rsi,%r14), %r11
	addq	%rsi, %rdi
	vmovddup	%xmm0, %xmm2
	addq	%r15, %rsi
	leaq	(%r12,%r11,8), %r11
	testb	$1, %dl
	vmovupd	(%r11), %xmm3
	vfmadd132pd	(%rbx,%rsi,8), %xmm3, %xmm2
	movslq	-88(%rbp), %rsi
	vmovddup	(%r10,%rsi,8), %xmm1
	vfmadd132pd	(%rbx,%rdi,8), %xmm2, %xmm1
	vmovupd	%xmm1, (%r11)
	je	.L20
	movl	-116(%rbp), %edi
	andl	$-2, %edx
	addl	%edi, %edx
.L21:
	leal	0(%r13,%rdx), %edi
	vmovsd	(%r10,%rsi,8), %xmm4
	movslq	%edi, %rdi
	leaq	(%r12,%rdi,8), %r11
	leal	(%r9,%rdx), %edi
	addl	%r8d, %edx
	movslq	%edi, %rdi
	vmovsd	(%r11), %xmm5
	movslq	%edx, %rdx
	vfmadd132sd	(%rbx,%rdi,8), %xmm5, %xmm0
	vfmadd231sd	(%rbx,%rdx,8), %xmm4, %xmm0
	vmovsd	%xmm0, (%r11)
.L20:
	movl	-148(%rbp), %edx
	movq	-160(%rbp), %rdi
	addq	$16, -96(%rbp)
	addl	%edx, %r8d
	addl	%edx, %r9d
	movl	-88(%rbp), %edx
	addq	%rdi, %r15
	addl	$2, %edx
	cmpl	%edx, -104(%rbp)
	je	.L84
	movl	%edx, -88(%rbp)
	movq	-96(%rbp), %rdx
	cmpl	$2, -64(%rbp)
	vmovsd	(%rdx), %xmm0
	ja	.L77
.L83:
	xorl	%edi, %edi
	movl	$3, %edx
	xorl	%esi, %esi
	movl	%edi, -116(%rbp)
	movslq	%r8d, %rdi
	jmp	.L31
.L84:
	movl	-88(%rbp), %r9d
	movl	-120(%rbp), %r15d
	movl	-128(%rbp), %edi
	movl	-132(%rbp), %edx
	movl	-136(%rbp), %r10d
	movq	-144(%rbp), %rsi
	leal	1(%r9,%r15), %r8d
.L35:
	movl	-60(%rbp), %r9d
	movslq	%r8d, %r15
	movl	%edi, -88(%rbp)
	movl	%r10d, -96(%rbp)
	imull	%r9d, %r8d
	movq	%rsi, -104(%rbp)
	movslq	%r8d, %r11
	.p2align 4,,10
	.p2align 3
.L29:
	movq	-56(%rbp), %rdi
	cmpl	$2, -64(%rbp)
	vmovsd	(%rdi,%r15,8), %xmm0
	jbe	.L43
	leaq	(%rbx,%r11,8), %rdi
	vbroadcastsd	%xmm0, %ymm2
	xorl	%esi, %esi
	.p2align 4,,10
	.p2align 3
.L25:
	vmovupd	(%rdi,%rsi), %ymm1
	vfmadd213pd	(%rax,%rsi), %ymm2, %ymm1
	vmovupd	%ymm1, (%rax,%rsi)
	addq	$32, %rsi
	cmpq	%rcx, %rsi
	jne	.L25
	movl	-76(%rbp), %esi
	testl	%esi, %esi
	je	.L26
	movl	-80(%rbp), %esi
	movl	%esi, %edi
.L24:
	movl	%edx, %r9d
	subl	%edi, %r9d
	cmpl	$1, %r9d
	je	.L27
	leaq	(%rdi,%r14), %r10
	addq	%r11, %rdi
	vmovddup	%xmm0, %xmm1
	testb	$1, %r9b
	leaq	(%r12,%r10,8), %r10
	vmovupd	(%r10), %xmm7
	vfmadd132pd	(%rbx,%rdi,8), %xmm7, %xmm1
	vmovupd	%xmm1, (%r10)
	je	.L26
	andl	$-2, %r9d
	addl	%r9d, %esi
.L27:
	leal	0(%r13,%rsi), %edi
	addl	%r8d, %esi
	movslq	%edi, %rdi
	movslq	%esi, %rsi
	leaq	(%r12,%rdi,8), %rdi
	vmovsd	(%rdi), %xmm6
	vfmadd132sd	(%rbx,%rsi,8), %xmm6, %xmm0
	vmovsd	%xmm0, (%rdi)
.L26:
	movq	-72(%rbp), %rdi
	addq	$1, %r15
	addl	%edx, %r8d
	addq	%rdi, %r11
	cmpl	%r15d, -60(%rbp)
	jg	.L29
	movl	-96(%rbp), %r10d
	movq	-104(%rbp), %rsi
	movq	%rdi, %r15
	movl	-88(%rbp), %edi
	addq	%rsi, -56(%rbp)
	addq	%r15, %r14
	subl	%r10d, -120(%rbp)
	addq	%rsi, %rax
	addl	%r10d, %r13d
	addl	$1, %edi
	cmpl	%edi, -60(%rbp)
	jne	.L18
	movl	-164(%rbp), %r9d
	movl	-168(%rbp), %r10d
	movq	-176(%rbp), %rsi
	movq	-184(%rbp), %r15
	rdtsc
	salq	$32, %rdx
	movq	%rax, %r13
	orq	%rdx, %r13
	cmpl	$2, %r10d
	jbe	.L36
	movl	%r9d, %eax
	vxorpd	%xmm0, %xmm0, %xmm0
	shrl	$2, %eax
	salq	$5, %rax
	addq	%r12, %rax
.L37:
	vaddsd	(%rsi), %xmm0, %xmm0
	addq	$32, %rsi
	vaddsd	-24(%rsi), %xmm0, %xmm0
	vaddsd	-16(%rsi), %xmm0, %xmm0
	vaddsd	-8(%rsi), %xmm0, %xmm0
	cmpq	%rsi, %rax
	jne	.L37
	movl	%r9d, %eax
	andl	$-4, %eax
	testb	$3, %r9b
	je	.L38
	movslq	%eax, %rcx
	vaddsd	(%r12,%rcx,8), %xmm0, %xmm0
	leaq	0(,%rcx,8), %rdx
	leal	1(%rax), %ecx
	cmpl	%r9d, %ecx
	jge	.L38
	addl	$2, %eax
	vaddsd	8(%r12,%rdx), %xmm0, %xmm0
	cmpl	%eax, %r9d
	jle	.L38
	vaddsd	16(%r12,%rdx), %xmm0, %xmm0
.L38:
	leaq	.LC14(%rip), %rsi
	movl	$2, %edi
	movl	$1, %eax
	vzeroupper
	call	__printf_chk@PLT
	movq	%r13, %rdx
	movl	$2, %edi
	xorl	%eax, %eax
	subq	%r15, %rdx
	leaq	.LC15(%rip), %rsi
	call	__printf_chk@PLT
	movq	-112(%rbp), %rdi
	call	free@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movq	%r12, %rdi
	call	free@PLT
	xorl	%eax, %eax
.L1:
	addq	$160, %rsp
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L43:
	.cfi_restore_state
	xorl	%edi, %edi
	xorl	%esi, %esi
	jmp	.L24
.L41:
	movl	-80(%rbp), %edx
	movslq	-88(%rbp), %rsi
	jmp	.L21
.L81:
	movq	(%rsi), %rcx
	movq	stderr(%rip), %rdi
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC2(%rip), %rdx
	call	__fprintf_chk@PLT
.L3:
	movl	$1, %eax
	jmp	.L1
.L39:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	jmp	.L7
.L82:
	movq	stderr(%rip), %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC3(%rip), %rdi
	call	fwrite@PLT
	jmp	.L3
.L40:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	jmp	.L13
.L36:
	vxorpd	%xmm0, %xmm0, %xmm0
	vaddsd	(%r12), %xmm0, %xmm0
	jmp	.L38
.L6:
	movl	-60(%rbp), %ecx
	movq	stderr(%rip), %rdi
	leaq	.LC4(%rip), %rdx
	xorl	%eax, %eax
	movl	$2, %esi
	call	__fprintf_chk@PLT
	movq	-112(%rbp), %rdi
	call	free@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movq	%r12, %rdi
	call	free@PLT
	jmp	.L3
	.cfi_endproc
.LFE6646:
	.size	main, .-main
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.set	.LC5,.LC0
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC12:
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
