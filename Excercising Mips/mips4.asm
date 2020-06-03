.data
.text
	addi $s0, $zero, 4
	sll  $s0, $s0, 3
	
	li $v0, 1
 	move $a0, $s0
 	syscall 