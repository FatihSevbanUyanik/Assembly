.data
	number1: .word 10
	number2: .word 30
.text
	lw $t0, number1($zero)
	lw $t1, number2($zero)
	add $t2, $t0, $t1
	
	li $v0, 1
 	addi $a0, $t2, 0
 	syscall 