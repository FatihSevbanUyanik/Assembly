.data
	octal_no: .space 20
	new_line: .asciiz "\n"
	wrong_input_message: .asciiz "Input is wrong."
	string_space: .space 1024
	request_octal: .asciiz "Please enter an octal number: "
	output_decimal: .asciiz "Decimal Number: "
.text
	main:	
 		jal interactWithUser
 		la $a1, octal_no
		jal convertToDec
		move $s1, $v0
		
 	       	addi $v0, $zero, 4
 	       	la $a0, output_decimal
 	   	syscall 
		
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
		addi $t1, $t1, -1
 		addi $t0, $t0, -1
 		
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
 	# convertToDec
 	
 	interactWithUser:
 		request_input:
 		addi $v0, $zero, 4
 	       	la $a0, request_octal
 	   	syscall 
 		
 		li $v0, 8
 		la $a1, 20
		la $a0, octal_no
		syscall
			
		la $t1, octal_no
				
		loop_3: lb $t3, 0($t1)
			addi $t1, $t1, 1
			addi $t2, $zero, 10
 			beq $t3, $t2, exit_3
 			addi $t2, $zero, 57
 			slt $t4, $t3, $t2
 			addi $t2, $zero, 48
 			slt $t5, $t3, $t2
 			addi $t6, $zero, 1
 			bne $t4, $t6, exit_4
 			bne $t5, $zero, exit_4		
 			j loop_3
 		exit_4:
 		
		addi $v0, $zero, 4
 		la $a0, wrong_input_message
 		syscall 
 		
 		addi $v0, $zero, 4
 		la $a0, new_line
 		syscall   			
 		
 		j request_input
 		
 		exit_3:
 		addi $v0, $zero, 1
 		jr $ra
 	# interactWithUser
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 
