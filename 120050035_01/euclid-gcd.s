.text
main:
#code starts here
	lui $t0,0x0000
	ori $t0,$t0,0x0005
	lui $t1,0x0000
	ori $t1,$t1,0x0009
	
gcd:
	beq $t0,$t1,exit
	slt $t2,$t1,$t0
	beq $t2,1,swap
	sub $t1,$t1,$t0
	j gcd
	
swap:
	or $t3,$t0,$0
	or $t0,$t1,$0
	or $t1,$t3,$0
	j gcd
	
exit:
	or $s0,$t0,$0
	
