.data
temp : .asciiz "next"
#.align 2
arrayi : .space 32

.text

main :
	la $s2, arrayi
	li $t7, 10
	sw $t7, 0($s2)
