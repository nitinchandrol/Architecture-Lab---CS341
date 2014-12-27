#fact(int n){
#	if(n == 0)
#		return 1;
#	else
#		return n*fact(n-1);
#}
.data
.text


fact:
	addi $sp,$sp,-8
	sw $ra,0($sp)
	sw $a0,4($sp)
	bne $a0,$zero,else
	li $v0,1
	j exit
	
else:
	addi $a0,$a0,-1
	jal fact
	lw $a0,4($sp)
	mul $v0,$v0,$a0
	
exit:
	lw $ra,0($sp)
	addi $sp,$sp,8
	jr $ra
	
main:
	li $a0,6
	jal fact
