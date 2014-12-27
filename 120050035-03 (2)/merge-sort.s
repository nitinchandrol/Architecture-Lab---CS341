.data

prompt1: .asciiz "Enter integer no "
prompt2: .asciiz " : "
newline: .asciiz	"\n"

.align 2
arr: .space 32
.align 2
temp: .space 32

.text

main:

	#a1 - lenght of the array
	#a0 - pointer of the array
	#s7 - pointer of temp array

	li $t0, 0
	la $a0, arr

	addi $s0, $a0, 0
	addi $t6, $s7, 0

	beginloop:
		beq $t0, 8, exit

		li $v0, 4
		la $a0, prompt1
		syscall
		
		li $v0, 1
		move $a0, $t0
		syscall

		li $v0, 4
		la $a0, prompt2
		syscall

		li $v0, 5
		syscall
		addi $s1, $v0, 0
		
		sw $s1, 0($s0)

		addi $t0, $t0, 1
		addi $s0, $s0, 4
		j beginloop
	exit:
	
	la $a0, arr
	li $a1, 8
	jal sort
	
	la $s0,arr
	li $t9, 0
	printloop:
		beq $t9, 8, exitlast
		li $v0, 1
		lw $t8, 0($s0)
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, newline
		syscall
		addi $s0, $s0, 4
		addi $t9, $t9, 1
		j printloop
	exitlast:

	j sysexit
		

merge:

	# $t1 - index1, $t2 - index2

	la $s7, temp

	addi $s5, $a0, 0
	addi $s6, $a3, 0
	li $t1, 0
	li $t2, 0
	loop:
		slt $s2, $t1, $a1
		slt $s3, $t2, $a2
		and $s4, $s2, $s3

		beq $s4, $0, exit1
		lw $t3, 0($s5)
		lw $t4, 0($s6)

		slt $t5, $t3, $t4
			beq $t5, $0, else1
			lw $t7, 0($s5)
			sw $t7, 0($s7)
			addi $s7, $s7, 4
			addi $s5, $s5, 4
			addi $t1, $t1, 1

			j exit2

			else1:
			lw $t7, 0($s6)
			sw $t7, 0($s7)
			addi $s7, $s7, 4
			addi $s6, $s6, 4
			addi $t2, $t2, 1		
			exit2:
	j loop
	exit1:
	bne $t1, $a1, exit3
	while1:
		beq $t2, $a2, exit5
			lw $t7, 0($s6)
			sw $t7, 0($s7)
			addi $s7, $s7, 4
			addi $s6, $s6, 4
			addi $t2, $t2, 1
			j while1
		exit5:
	exit3:
	bne $t2, $a2, exit4
	while2:
		beq $t1, $a1, exit6
			lw $t7, 0($s5)
			sw $t7, 0($s7)
			addi $s7, $s7, 4
			addi $s5, $s5, 4
			addi $t1, $t1, 1
			j while2
		exit6:
	exit4:
	jr $ra

sort:
	addi $sp,$sp,-24
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	addi $t4,$zero,1
	bne $a1,$t4,else
		j final_exit
	
	else:
	srl $t9,$a1,1
	sw $t9,16($sp)
	addi $a1,$t9,0
	jal sort
	
	lw $a1,8($sp)
	lw $a0,4($sp)
	srl $t9,$a1,1
	sll $t5,$t9,2
	add $a0,$t5,$a0
	addi $a1,$t9,0
	sw $a0,20($sp)
	jal sort
	
	lw $a0,4($sp)
	lw $a3,20($sp)
	lw $a1,16($sp)
	lw $a2,16($sp)
	jal merge
	lw $a1,8($sp)
	addi $t0,$a1,0
	la $s7,temp
	lw $a0,4($sp)
	while:
		beq $t0,$zero,exit7
		addi $t0,$t0,-1
		lw $t1,0($s7)
		sw $t1,0($a0)
		addi $s7,$s7,4
		addi $a0,$a0,4
		j while
	exit7:
	
final_exit:
	lw $ra,0($sp)
	addi $sp,$sp,24
	jr $ra
	
sysexit:

