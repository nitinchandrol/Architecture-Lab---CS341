.text
main:
#code starts here
	lui $t0,0x1000
	ori $t0,$t0,0x0001
	lui $t1,0x2000
	ori $t1,$t1,0x0002
	add $s0,$t0,$t1 
