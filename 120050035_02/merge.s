.data

info: .asciiz "The first four Integers You give, forms Array-1 and the last 4 integers form Array 2 \n"
read: .asciiz "Enter in an Integer :"
done: .asciiz "Done Storing........ \n"
outp: .asciiz "The Output array is :"b
newline: .asciiz "\n"
.align 2
array_ntn: .space 32
array: .space 32

.text
main:	
		la $s1 array_ntn  		#address of first array
		addi $a1 $s1 16 		#address of second array
		la $a2 array			#address of output array
		li $a3 4				#length left of first array
		li $s0 4				#length left of second array
		
		ori $t4 $s1 0
		
		li $t0 0
		li $t1 8

		li $v0 4
		la $a0 info
		syscall
		
loop:	
		li $v0 4
		la $a0 read
		syscall
		li $v0 5
		syscall
		sw $v0 0($t4)
		addi $t0 $t0 1
		beq $t0 $t1 dones
		addi $t4 $t4 4	
		j loop
dones:
		li $v0 4
		la $a0 done
		syscall
		
merge:
		add $t2 $a3 $s0
		beq $t2 0 exit1
		beq $a3 0 case1
		beq $s0 0 case2
		j case3
		
case1: 
		lw $t3 0($a1)
		sw $t3 0($a2)
		addi $a1 $a1 4
		addi $a2 $a2 4
		addi $s0 $s0 -1
		j merge
		
case2:  
		lw $t3 0($s1)
		sw $t3 0($a2)
		addi $s1 $s1 4
		addi $a2 $a2 4
		addi $a3 $a3 -1
		j merge
		
case3:
		lw $t3 0($s1) 
		lw $t4 0($a1)
		slt $t5 $t3 $t4
		beq $t5 1 case2
		j case1
		
exit1:  li $t1 0
		li $t2 8
		li $v0 4
		addi $a2 $a2 -32
		la $a0 outp
		syscall
		j exit
exit:	
		li $v0 4
		la $a0 newline
		syscall
		li $v0 1
		lw $a0 0($a2)
		syscall

		addi $a2 $a2 4
		addi $t1 $t1 1
		beq $t1 $t2 exitmax
		j exit
exitmax: 
		
		
		
		
