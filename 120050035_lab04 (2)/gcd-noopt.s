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
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	reorder
	addiu	$sp,$sp,-8
	#stored $fp on stack
	sw	$fp,4($sp)
	move	$fp,$sp
	#stored inputs to stack
	sw	$4,8($fp)
	sw	$5,12($fp)
$L5:
	#loaded the inputs from stack to $v0 and $v1
	lw	$3,8($fp)
	lw	$2,12($fp)
	#nop
	# if (x==y) return x
	bne	$3,$2,$L2
	#loaded x from stack to $v0
	lw	$2,8($fp)
	#restored $sp and $fp
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	# j $ra
	j	$31
$L2:
	#loaded the inputs from stack to $v0 and $v1
	lw	$3,8($fp)
	lw	$2,12($fp)
	#nop
	#if(x > y ) go to $L3
	slt	$2,$2,$3
	beq	$2,$0,$L3
	#loaded inputs from stack
	lw	$3,8($fp)
	lw	$2,12($fp)
	#nop
	# x=x-y
	subu	$2,$3,$2
	#modified new x
	sw	$2,8($fp)
	# call to $l5 as loop
	b	$L5
$L3: #the else part
	lw	$3,12($fp)
	lw	$2,8($fp)
	#nop
	# y = y - x and store y
	subu	$2,$3,$2
	sw	$2,12($fp)
	# call to loop
	b	$L5
	.end	gcd

	.align	2
	.globl	main
	.set	nomips16
	.ent	main
main:
	.frame	$fp,40,$31		# vars= 8, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	reorder
	addiu	$sp,$sp,-40
	# stored $ra onto the stack
	sw	$31,36($sp)
	#store $fp onto the stack
	sw	$fp,32($sp)
	# $sp is copied to $fp
	move	$fp,$sp
	#stored $a1 and $a1 on stack
	sw	$4,40($fp)
	sw	$5,44($fp)
	#loaded 48 to $v0 and stored it on stack
	li	$2,48			# 0x30
	sw	$2,28($fp)
	#loaded 15 to $vo and storedit on stack
	li	$2,15			# 0xf
	sw	$2,24($fp)
	#loaded the two nputs to $a0 and $a1
	lw	$4,28($fp)
	lw	$5,24($fp)
	#called gcd function
	jal	gcd
	# moved the output from gcd of $v0 to $v1
	move	$3,$2
	#loaded the address of result array on $v0
	la	$2,result
	#stored the output on result array
	sw	$3,0($2)
	la	$2,result
	lw	$2,0($2)
	#nop
	#moved the reult to $a0
	move	$4,$2
	jal	syscall_print_int
	jal	syscall_print_newline
	move	$2,$0
	#moved $fp to $sp
	move	$sp,$fp
	#restored $ra and $fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	#restored $sp
	addiu	$sp,$sp,40
	# j $ra
	j	$31
	.end	main
