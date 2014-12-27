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
	
	li $a1, 4
	li $a2, 4
	li $t0, 0
	la $a0, arr

	addi $s0, $a0, 0

	addi $a3, $s0, 16

	la $s7, temp
	sw $s7, 0($sp)

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

	jal merge
	
	li $t9, 0
	printloop:
		beq $t9, 8, exitlast
		li $v0, 1
		lw $t8, 0($t6)
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, newline
		syscall
		addi $t6, $t6, 4
		addi $t9, $t9, 1
		j printloop
	exitlast:

	j sysexit
		

merge:

	# $t1 - index1, $t2 - index2

	lw $s7, 0($sp)

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
	
sysexit:
