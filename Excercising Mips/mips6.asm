.data
.text
	addi $s0, $zero, 100	
	addi $s1, $zero, 12
	div  $s0, $s1    
	
	mflo $t0 # quotient
	mfhi $t1 # reminder
		
	li $v0, 1
 	move $a0, $t1
 	syscall 