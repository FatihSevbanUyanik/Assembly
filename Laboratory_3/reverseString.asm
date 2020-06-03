.data
	string1: .asciiz "fatih"
	string2: .asciiz "abcde"
.text
	la $a0, string1 
	la $a1, string2 
	move $a2, $zero	
	jal reverseString
	
	li $v0, 4
 	la $a0, string2
 	syscall 
	
	# main
	li $v0, 10
 	syscall 
 	
reverseString:
	addi $sp, $sp, -32
 	sw $ra, 0($sp)
 	sw $s0, 4($sp)
 	sw $s1, 8($sp)
 	sw $s2, 12($sp) 
 	sw $s3, 16($sp)
 	sw $s4, 20($sp)
  	sw $s5, 24($sp)  	
  	sw $s6, 28($sp)
 
 	move $s0, $a0	
 	move $s1, $a1	
 	move $s2, $a2
 	lbu $s3, 0($s0)
 	
 	bne $s3, $zero, else_2
 	sb $zero, 0($s1)
 	move $v0, $zero 
 	j jump_2
 	else_2:
 	addi $a0, $s0, 1
 	addi $a1, $s1, 1  
 	addi $a2, $s2, 1  
 	jal reverseString
 	sub $s2, $s2, $v0
 	sub $s4, $s1, $s2
 	lbu $s3, 0($s0)
 	sb $s3, 0($s4)
 	addi $v0, $v0, 1	
 	jump_2:
 	
 	lw $ra, 0($sp)
 	lw $s0, 4($sp)
 	lw $s1, 8($sp)
 	lw $s2, 12($sp)
 	lw $s3, 16($sp) 
 	lw $s4, 20($sp) 
 	lw $s5, 24($sp)
 	lw $s6, 28($sp)
 	addi $sp, $sp, 32
 	jr $ra
