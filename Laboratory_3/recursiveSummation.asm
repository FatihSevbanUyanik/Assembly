.data
	number: .asciiz "312804589"
	new_line: .asciiz "\n"
	
.text
	la $a0, number 
	jal sum_recursive
 	move $t1, $v0
 	
 	li $v0, 1
 	move $a0, $t1
 	syscall 
 	
 	# main
	li $v0, 10
 	syscall 
 	
sum_recursive:
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
 	lbu $s1, 0($s0)
 	
 	# BASE CASE 
 	bne $s1, $zero, jump_1
 	move $v0, $zero
 	j jump_2
 	jump_1:
 	
 	addi $a0, $s0, 1 
 	jal sum_recursive
 	
 	# RECURSIVE CASE
 	lbu $s1, 0($s0)
 	addi $s1, $s1, -48
 	move $s2, $v0
 	add $s2, $s2, $s1
 	move $v0, $s2
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