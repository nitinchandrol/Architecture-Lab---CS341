.data
prompt:	.asciiz "Enter integer: "
done:	.asciiz "Done"
newline: .asciiz	"\n"

.align 2
array: .space 32
.align 2
temp: .space 32	
.text

main:
	la $t0,array
	li $t2, 8
	li $t3, 8																																																																																																																																																																						

branch:
	beq $t2,$0,exit
	
	# prompt for input
	li	$v0, 4
	la	$a0, prompt
	syscall
	# read in the value
	li	$v0, 5
	syscall
	move $t1,$v0
	
	sw $t1,0($t0)
	addi $t0,$t0,4
	addi $t2,$t2,-1
	j branch

exit:
# prompt for done
	li	$v0, 4
	la	$a0, done
	syscall
	la $a0,array
	addi $a1,$t3,0
	jal sort
	j ntn_exit

merge:

	# $t1 - index1, $t2 - index2
	addi $sp,$sp,-12
	sw $ra,0($sp) 
	sw $a1,4($sp)
	la $s7,temp
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
	lw $ra,0($sp)
	lw $t9,4($sp)
	sll $t9,$t9,3
	addi $sp,$sp,8
	sub $v1,$s7,$t9
	jr $ra

sort:
	addi $sp,$sp,-20
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	addi $t4,$zero,1
	bne $a1,$t4,else
	addi $v1,$a0,0
	j final_exit
	
else:
	srl $t9,$a1,1
	sw $t9,16($sp)
	lw $a0,4($sp)
	addi $a1,$t9,0
	jal sort
	sw $v1,12($sp)
	
	lw $a1,8($sp)
	lw $a0,4($sp)
	srl $t9,$a1,1
	sll $t5,$t9,2
	add $a0,$t5,$a0
	addi $a1,$t9,0
	jal sort
	
	lw $a0,12($sp)
	addi $a3,$v1,0
	lw $a1,16($sp)
	lw $a2,16($sp)
	jal merge
	
final_exit:
	lw $ra,0($sp)
	addi $sp,$sp,20
	jr $ra
	
ntn_exit:	
	
