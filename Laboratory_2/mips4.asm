.data
	array: .space 400
	array_size: .word 100
	array_length: .word 0
	request_aray_length: .asciiz "Please enter the length of the array: "
	request_aray_item_1: .asciiz "Please enter the "
	request_aray_item_2: .asciiz " item: "
	content_of_array: .asciiz "Array Content: "	
	add_space: .asciiz "  "
	new_line: .asciiz "\n"

.text
	main:
		addi $s0, $zero, 0
		lw $s1, array_size
		la $s2, array
		
		# requesting length
 		addi $v0, $zero, 4
 		la $a0, request_aray_length
 		syscall 
 	
 		# getting user input
 		addi $v0, $zero, 5
 		syscall 
 	
 		# storing length
 		add $s3, $zero, $v0
 		sw $s3, array_length
 	
 		j check_1
 	
		# requesting items
 		for_1: 	addi $v0, $zero, 4
 	       		la $a0, request_aray_item_1
 	       		syscall 
 	       
 	       		# printing an integer
 	       		addi $v0, $zero, 1
 	       		addi $a0, $s0, 1
 	       		syscall 
 	
 	      	 	# requesting item
 	       		addi $v0, $zero, 4
 	       		la $a0, request_aray_item_2
 	       		syscall 
 	       
 	       		# getting user input
 	       		addi $v0, $zero, 5
 	       		syscall 
 	       
 	       		sw $v0, 0($s2)
 	       		addi $s2, $s2, 4 
 	       		addi $s0, $s0, 1
 	       
 	       		check_1: bne $s0, $s3, for_1
 	
 		# Display content
 		la $s2, array
 		addi $a0, $s2, 0
 		addi $a1, $s3, 0
 		jal display_array
 		       		       	
 		la $s2, array
 		addi $a0, $s2, 0
 		addi $a1, $s3, 0
 		jal bubbleSort	
 					
 		# Display content
 		la $s2, array
 		addi $a0, $s2, 0
 		addi $a1, $s3, 0
 		jal display_array													
 																	
 	# main
	li $v0, 10
 	syscall 	
 	
 	
 	bubbleSort:
 		addi $sp, $sp, -24
 		sw $ra, 0($sp)
 		sw $s0, 4($sp)
 		sw $s1, 8($sp)
 		sw $s2, 12($sp) 
 		sw $s3, 16($sp) 
 		sw $s4, 20($sp) 
 		
 		move $s0, $a0 # array
 		move $s1, $a1 # length
 		move $s2, $zero
 		addi $s3, $s1, -1	
 		
 		for_3: 	beq $s2, $s1, exit_3
 			move $s4, $zero
 			move $s5, $s0
 			for_4:	beq $s4, $s3, exit_4 
 				lw $t0, 0($s5)
 				lw $t1, 4($s5) 		
 	       			
 	       			slt $t2, $t0, $t1
 	       			beq $t2, $zero, jump_1
 	       			move $t2, $t0
 	       			move $t0, $t1
 	       			move $t1, $t2
 	       			sw $t0, 0($s5)
 				sw $t1, 4($s5) 	
 	       			jump_1:
 	       			addi $s4, $s4, 1
 	       			addi $s5, $s5, 4
 	       			j for_4
 	       		
 	       		exit_4:
 	       		addi $s2, $s2, 1
 	       		j for_3
 	       	
 	       	exit_3:
 	       	
 	       	
 	       	lw $ra, 0($sp)
 		lw $s0, 4($sp)
 		lw $s1, 8($sp)
 		lw $s2, 12($sp)
 		lw $s3, 16($sp) 
 		lw $s4, 20($sp) 
 		addi $sp, $sp, 24
 	       	jr $ra
 	       	
 	display_array:
 		addi $sp, $sp, -16
 		sw $ra, 0($sp)
 		sw $s0, 4($sp)
 		sw $s1, 8($sp)
 		sw $s2, 12($sp) 
 		
 		move $s0, $zero
 		move $s1, $a0				
 	 	move $s2, $a1				
 		
 		addi $v0, $zero, 4
 		la $a0, content_of_array
 		syscall 
 		
 		j check_2
 		
 		# requesting items
 		for_2: 	lw $t0, 0($s1)
 			
 			# printing an integer
 	       		addi $v0, $zero, 1
 	       		addi $a0, $t0, 0
 	       		syscall 
 	
 	       		addi $v0, $zero, 4
 	       		la $a0, add_space
 	       		syscall 
 	       
 	       		addi $s1, $s1, 4 
 	       		addi $s0, $s0, 1
 	       
 	       		check_2: bne $s0, $s2, for_2
 	       	
 	       	addi $v0, $zero, 4
 	       	la $a0, new_line
 	       	syscall
 	       	
 	       	lw $ra, 0($sp)
 		lw $s0, 4($sp)
 		lw $s1, 8($sp)
 		lw $s2, 12($sp)
 		addi $sp, $sp, 16
 	       	jr $ra
 	# display_array
 	
 	
 	
 	

 
 	
 	
