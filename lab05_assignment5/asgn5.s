# compile from C to this assembly using: gcc -S asgn5.c
# run file is asgn5_asm: gcc asgn5.s -o asgn5_asm
	
	.file	"asgn5.c"			# source file name
	.text						# code section
	.section	.rodata			# read-only data section
.LC0:
	.string	"%d \n"	  			# format string for printf
	.text			  			# back to code section
	.globl	main				# make main visible
	.type	main, @function		# declare main as a function
main:							# main function entry point
.LFB0:
	.cfi_startproc				# start function
	endbr64						# security instruction
	pushq	%rbp				# save old base pointer

	.cfi_def_cfa_offset 16		# define the offset for the new stack frame
	.cfi_offset 6, -16			# define the offset for the old base pointer (rbp) in the new stack frame
	movq	%rsp, %rbp			# set new stack frame
	
	.cfi_def_cfa_register 6		# define the new base pointer register (rbp) for the current stack frame
	subq	$48, %rsp	   		# allocate space for variables
	movq	%fs:40, %rax		# stack canary for security
	movq	%rax, -8(%rbp)		# save stack canary
	xorl	%eax, %eax			# clear eax for later use

	# Initialize the array with values 1 to 5
	movl	$1, -32(%rbp)		# arr[0] = 1
	movl	$2, -28(%rbp)		# arr[1] = 2
	movl	$3, -24(%rbp)		# arr[2] = 3
	movl	$4, -20(%rbp)		# arr[3] = 4
	movl	$5, -16(%rbp)		# arr[4] = 5

	# Pointer ptr = arr;
	leaq	-32(%rbp), %rax		# load address of arr into rax
	movq	%rax, -40(%rbp)		# ptr stored at -40(%rbp)

	movl	$0, -48(%rbp)		# i = 0

	jmp	.L2						# jump to the start of the loop

# LOOP 1: square each element in the array
.L3:							# loop body: ptr[i] = ptr[i] * ptr[i];
	# calculate ptr[i]
	movl	-48(%rbp), %eax		# eax = i
	cltq						# convert i to 64-bit
	leaq	0(,%rax,4), %rdx	# rdx = i * 4 (size of int)
	movq	-40(%rbp), %rax		# rax = ptr
	addq	%rdx, %rax			# rax = ptr + i * 4 (address of ptr[i])
	movl	(%rax), %edx		# edx = ptr[i]
	
	# calculate ptr[i] * ptr[i]
	movl	-48(%rbp), %eax		# eax = i
	cltq						# convert i to 64-bit
	leaq	0(,%rax,4), %rcx	# rcx = i * 4 (size of int)
	movq	-40(%rbp), %rax		# rax = ptr
	addq	%rcx, %rax			# rax = ptr + i * 4 (address of ptr[i])
	movl	(%rax), %eax		# eax = ptr[i]

	# ptr[i] = ptr[i] * ptr[i]
	movl	-48(%rbp), %ecx		# ecx = i
	movslq	%ecx, %rcx			# convert i to 64-bit
	leaq	0(,%rcx,4), %rsi	# rsi = i * 4 (size of int)
	movq	-40(%rbp), %rcx		# rcx = ptr
	addq	%rsi, %rcx			# rcx = ptr + i * 4 (address of ptr[i])
	imull	%edx, %eax			# eax = ptr[i] * ptr[i]
	movl	%eax, (%rcx)		# store the result back to ptr[i]
	addl	$1, -48(%rbp)		# i++
.L2:							# loop condition: i < 5
	# loop condition: i < 5
	cmpl	$4, -48(%rbp)		# compare i with 4 (since we want to loop while i < 5)
	jle	.L3						# if i <= 4, jump to loop body
	
# LOOP 2: print each element in the array
	# reset i for the next loop
	movl	$0, -44(%rbp)		# i = 0 for the next loop
	jmp	.L4						# jump to the start of the next loop
.L5:							# loop body: printf("%d \n", ptr[i]);
	movl	-44(%rbp), %eax		# eax = i
	cltq						# convert i to 64-bit

	leaq	0(,%rax,4), %rdx	# rdx = i * 4 (size of int)
	movq	-40(%rbp), %rax		# rax = ptr
	addq	%rdx, %rax			# rax = ptr + i * 4 (address of ptr[i])

	movl	(%rax), %eax		# eax = ptr[i]
	movl	%eax, %esi			# move ptr[i] into esi for printf argument

	leaq	.LC0(%rip), %rax	# load address of format string into rax
	movq	%rax, %rdi			# move format string address into rdi for printf argument

	movl	$0, %eax			# clear eax for variadic function call
	call	printf@PLT			# call printf to print the value of ptr[i]
	addl	$1, -44(%rbp)		# i++
.L4:							# loop condition: i < 5
	cmpl	$4, -44(%rbp)		# compare i with 4 (since we want to loop while i < 5)
	jle	.L5						# if i <= 4, jump to loop body
# return 0 from main
	movl	$0, %eax			# return 0
	
	# stack canary check before returning
	movq	-8(%rbp), %rdx		# load stack canary into rdx
	subq	%fs:40, %rdx		# compare with original stack canary
	je	.L7						# if they match, jump to return
	call	__stack_chk_fail@PLT	# if they don't match, call stack check fail function
.L7:
	leave						# restore stack frame
	.cfi_def_cfa 7, 8			# define the canonical frame address for the caller (old base pointer)
	ret							# return from main
	.cfi_endproc				# end of function
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
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
