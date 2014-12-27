	.data
prompt:	.asciiz "Enter integer: "
done:	.asciiz "Done"
newline: .asciiz	"\n"
.align 2
array: .space 32
	
.text

main:
	la $t0,array
	li $t2, 8

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
