	.data
prompt1:	.asciiz "Enter 1st integer: "
prompt2:	.asciiz "Enter 2nd integer: "
newline: .asciiz	"\n"
sum:	.asciiz	"Sum: "
	.globl	main

.text
main:
# prompt for input1
	li	$v0, 4
	la	$a0, prompt1
	syscall
	
# read in the value1
	li	$v0, 5
	syscall
	move $s0, $v0
	
# prompt for input1
	li	$v0, 4
	la	$a0, prompt2
	syscall
		
# read in the value2	
	li	$v0, 5
	syscall
	move $s1, $v0
	
# prompt for sum
	li	$v0, 4
	la	$a0, sum
	syscall

# addition	
	add $a0,$s0,$s1
	li $v0,1
	syscall
	
# prompt for newline
	li	$v0, 4
	la	$a0, newline
	syscall
