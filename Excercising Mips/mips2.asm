.data
	number1: .word 50
	number2: .word 10
.text
	lw $s0, number1($zero)
	lw $s1, number2($zero)
	sub $s2, $s0, $s1
	
	li $v0, 1
 	move $a0, $s2
 	syscall 