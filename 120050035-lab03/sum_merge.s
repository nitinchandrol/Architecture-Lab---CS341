.data
	result:		.asciiz "The result is:"

	.align 2
	array0		:.space	16
	array1		:.space 16
	arrayfirst	:.space	32
	arrayReturn:.space	32
	space:		.asciiz " "

.text
main:
	la 	$s2,arrayfirst
	li	$t1,0
	li 	$t3,8

	add $t4,$s2,0

	loop:
	beq	$t1,$t3,exit
		li		$v0,5
		syscall
		sw		$v0,0($t4)
		addi	$t4,$t4,4
		addi	$t1,$t1,1
		j loop
	exit:

	addi $a0,$s2,0
	addi $a1,$s2,16

	#la $v0,arrayReturn

	
	addi $sp,$sp,-4
	la	$t3, arrayReturn
	sw	$t3, 0($sp)

	
	li	$a2,4
	li	$a3,4


	jal mergeing

	 move 	$s0,$v0 
	 li $v0, 4 #syscall to print string 
	 la 	$a0, result #address of string to print 
	 syscall 
	 
	 addi	$t3,$v0,0

	 li 	$t0,0 
	 li 	$s1,8 
	 while: 
	 beq 	$t0,$s1,whileexit 
		 	li $v0, 4 #syscall to print string 
		 	la $a0, space #address of string to print 
		 	syscall 

			li $v0,1 
			sll $t1,$t0,2 
			add $t3,$t1,$s0 
			lw $a0,0($t3) 
			syscall 
			addi $t0,$t0,1 
			j while 
	whileexit: 
	j sysexit
	

mergeing:
	# $a0 => array0
	# $a1 => array1
	# $a2 => length of array0
	# $a3 => length of array1
	# $t2 => length of result array(=$a2+a3)
	# $v0 => return array

	lw	$v0,0($sp)

	li		$t0,0	# index of array0
	li		$t1,0	# index of array1
	add 	$t2,$t1,$t0

	whileLoop:
		slt		$t3,$t0,$a2
		slt 	$t4,$t1,$a3
		and		$t5,$t3,$t4
		beq		$t5,$0,break1
			sll 	$t3,$t0,2
			add		$t3,$a0,$t3		#current index address of a0
			
			sll	$t4,$t1,2
			add 	$t4,$a1,$t4
			
			lw		$s0,0($t3)		#a0[index0]
			lw		$s1,0($t4)		#a1[index1]

			add 	$s3,$t1,$t0		#$s3=> stores t0+t1
			sll	$s3,$s3,2
			add 	$s3,$s3,$v0		#$s3 is the address of v0[index0+index1]
			
			slt		$t9,$s0,$s1

			beq		$t9,$0,else
				sw		$s0,0($s3)
				addi 	$t0,$t0,1
				j 		whileLoop
			else:
				sw		$s1,0($s3)
				addi	$t1,$t1,1
				j		whileLoop
	break1:
		bne		$t0,$a2,else2
			whileLoop2:
			beq		$t1,$a3,Break2
				sll	$t4,$t1,2
				add 	$t4,$a1,$t4
				lw		$s1,0($t4)

				add 	$s3,$t1,$t0		#$s3=> stores t0+t1
				sll	$s3,$s3,2
				add 	$s3,$s3,$v0		#$s3 is the address of v0[index0+index1]

				sw		$s1,0($s3)
				addi	$t1,$t1,1

				j		whileLoop2
			
			Break2:
				j		FinalBreak
		else2:
			whileLoop3:
			beq		$t0,$a2,Break3
				sll	$t4,$t0,2
				add 	$t4,$a0,$t4
				lw 		$s1,0($t4)


				add 	$s3,$t1,$t0		#$s3=> stores t0+t1
				sll	$s3,$s3,2
				add 	$s3,$s3,$v0		#$s3 is the address of v0[index0+index1]

				sw		$s1,0($s3)
				addi	$t0,$t0,1
				j		whileLoop3

			Break3:
				j		FinalBreak
	FinalBreak:
		jr		$ra




sysexit:

