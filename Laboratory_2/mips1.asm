.data
	octal_no: .asciiz "5262"
	new_line: .asciiz "\n"
.text
	main:
		la $a1, octal_no
		jal convertToDec
	
		move $s1, $v0
		
		# printing an integer
 	       	addi $v0, $zero, 1
 	       	addi $a0, $s1, 0
 	   	syscall 
		
	# main
	li $v0, 10
 	syscall 
 	
 	convertToDec:
 		addi $sp, $sp, -8
 		sw $ra, 0($sp)
 		sw $a1, 4($sp)
 	
 		addi $t0, $a1, 0
 		addi $t1, $zero, 0
 		
 		loop_1: lbu $t2, 0($t0)
 			beq $t2, $zero, exit_1
 			addi $t0, $t0, 1
 			addi $t1, $t1, 1
 			j loop_1
 			
 		exit_1: 
 			
 		addi $t2, $zero, 0
 		addi $t4, $zero, 1
 		addi $t5, $zero, 0
 		
 		loop_2: beq $t1, $zero, exit_2
 			addi $t1, $t1, -1
 			addi $t0, $t0, -1
 			lb $t3, 0($t0)
 			addi $t3, $t3, -48	
 			beq $t5, $zero, jump_1
 			mul $t4, $t4, 8	
 			mul $t3, $t3, $t4
 			jump_1:
 			add $t5, $t5, 1
 			add $t2, $t2, $t3
 			j loop_2
 		exit_2:	
 			
 		addi $v0, $t2, 0
 		lw $ra, 0($sp)
 		lw $a1, 4($sp)
 		jr $ra
 		
