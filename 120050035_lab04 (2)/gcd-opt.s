	.file	1 "gcd.c"
	.data
	newline: .asciiz	"\n"
	.align 2
	result: .space 4
	.text
	.align	2
	.globl	gcd
	.set	nomips16
	.ent	gcd
syscall_print_int:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	li	$v0, 1
	# Using $a0 as argument
	syscall
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr	$ra
	nop

syscall_print_newline:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	li	$v0, 4
	la	$a0, newline
	syscall
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	nop

gcd:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	reorder
	move	$2,$4
	bne	$4,$5,$L7
	j	$31
$L5:
	bne	$5,$2,$L7
	j	$31
$L7:
	slt	$3,$5,$2
	beq	$3,$0,$L4
	subu	$2,$2,$5
	b	$L5
$L4:
	subu	$5,$5,$2
	b	$L5
	.end	gcd
	.align	2
	.globl	main
	.set	nomips16
	.ent	main
main:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 16, gp= 8
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	reorder
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	li	$4,48			# 0x30
	li	$5,15			# 0xf
	jal	gcd
	la	$3,result
	sw	$2,0($3)
	move	$4,$2
	jal	syscall_print_int
	jal	syscall_print_newline
	move	$2,$0
	lw	$31,28($sp)
	addiu	$sp,$sp,32
	j	$31
	.end	main

