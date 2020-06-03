.data
.text
	addi $s0, $zero, 100	
	addi $s1, $zero, 5
	div  $s3, $s0, $s1 # div  $s3, $s0, $s1 => can also be a number
	
	li $v0, 1
 	move $a0, $s3
 	syscall 