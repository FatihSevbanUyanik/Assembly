.data
	character: .byte  '\n'
.text
	addi $s0, $zero, 5000
	addi $s1, $zero, 6000
	mult $s0, $s1
	
	li $v0, 1
 	mflo $a0
 	syscall 
 	
 	li $v0, 1
 	mfhi $a1
 	syscall 