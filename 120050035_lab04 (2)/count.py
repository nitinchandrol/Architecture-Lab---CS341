#! /usr/bin/python
f = open("inst2.txt","r")
sc_count = 0
mc_count = 0
branch = ['beq', 'bne', 'bgez']
for line in f:
	sc_count = sc_count + 1
	temp = line.split(" ")
	if temp[2] == 'lw':
		mc_count = mc_count + 5
	else:
		if temp[2] in branch:
			mc_count = mc_count + 3
		else:
			mc_count = mc_count + 4

print ("No of single Cycle = " + str(sc_count) + "\n")
print ("No of multi Cycle = " + str(mc_count) + "\n")
ratio = (sc_count * 5.0)/ mc_count
print ("Multicycle is faster by " + str(ratio) + "\n")
