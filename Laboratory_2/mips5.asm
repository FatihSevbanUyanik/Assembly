.data
	request_aray_length: .asciiz "Please enter the length of the array: "
	request_aray_item_1: .asciiz "Please enter the "
	request_aray_item_2: .asciiz " item: "	
	content_of_array: .asciiz "Array Content: "
	array_length: .word 0
	add_space: .asciiz "  "
	new_line: "\n"
	initial_message: .asciiz "You need to provide an array to make further operations!"
	option_1: .asciiz "1. Display Array"
	option_2: .asciiz "2. Bubble Sort"
	option_3: .asciiz "3. Mode"
	option_4: .asciiz "4. 3rd Min and Max"
	option_5: .asciiz "5. Read New Array"
	option_6: .asciiz "6. Quit."
	decision: .asciiz "Please make a decision: "
	seperator: .asciiz "-----------------------------------------"
	third_minimum: .asciiz "Third Min: "
	third_maximum: .asciiz "Third Max: "
	mode_desc: .asciiz "Mode: "
	
.text
	main:
	
		# print initial message
 		addi $v0, $zero, 4
 		la $a0, initial_message
 		syscall 
 		
 		addi $v0, $zero, 4
 		la $a0, new_line
 		syscall 
 		
		jal readArray
		addi $s6, $v0, 0
		addi $s7, $v1, 0
	
		for_9:	addi $v0, $zero, 4
 			la $a0, new_line
 			syscall
		
			addi $v0, $zero, 4
 			la $a0, seperator
 			syscall 
 			
 			addi $v0, $zero, 4
 			la $a0, new_line
 			syscall 
 			
			addi $v0, $zero, 4
 			la $a0, option_1
 			syscall 
 		
 			addi $v0, $zero, 4
 			la $a0, new_line
 			syscall 
		
			addi $v0, $zero, 4
 			la $a0, option_2
 			syscall 
 		
 			addi $v0, $zero, 4
 			la $a0, new_line
 			syscall 
		
			addi $v0, $zero, 4
 			la $a0, option_3
 			syscall 
 		
 			addi $v0, $zero, 4
 			la $a0, new_line
 			syscall 
		
			addi $v0, $zero, 4
 			la $a0, option_4
 			syscall 
 		
 			addi $v0, $zero, 4
 			la $a0, new_line
 			syscall 
			
			addi $v0, $zero, 4
 			la $a0, option_5
 			syscall 
 		
 			addi $v0, $zero, 4
 			la $a0, new_line
 			syscall 
 			
 			addi $v0, $zero, 4
 			la $a0, option_6
 			syscall 
 		
 			addi $v0, $zero, 4
 			la $a0, new_line
 			syscall 
			
			addi $v0, $zero, 4
 			la $a0, seperator
 			syscall 
 			
 			addi $v0, $zero, 4
 			la $a0, new_line
 			syscall 
 			
 			addi $v0, $zero, 4
 			la $a0, decision
 			syscall 
 			
 			# getting user input
 			addi $v0, $zero, 5
 			syscall 
																					
			move $s2, $v0	
			addi $s3, $zero, 1
			
			addi $v0, $zero, 4
 			la $a0, new_line
 			syscall 
			
			beq $s2, $s3, jump_7
			j pass_7
			jump_7:
			move $a0, $s6
			move $a1, $s7
			jal display_array
			pass_7:
			
			addi $s3, $s3, 1
			
			beq $s2, $s3, jump_8
			j pass_8
			jump_8:
			move $a0, $s6
			move $a1, $s7
			jal bubbleSort
			pass_8:
			
			addi $s3, $s3, 1
			
			beq $s2, $s3, jump_9
			j pass_9
			jump_9:
			move $a0, $s6
			move $a1, $s7
			jal mode
			move $s0, $v0
			
			addi $v0, $zero, 4
 			la $a0, mode_desc
 			syscall
			
			addi $v0, $zero, 1
 			move $a0, $s0
 			syscall
 			
 			addi $v0, $zero, 4
 			la $a0, new_line
 			syscall 
			
			pass_9:
			
			addi $s3, $s3, 1
			
			beq $s2, $s3, jump_10
			j pass_10
			jump_10:
			
			move $a0, $s6
			move $a1, $s7
			jal thirdMinThirdMax
			move $s0, $v0
			move $s1, $v1
			
			addi $v0, $zero, 4
 			la $a0, third_maximum
 			syscall
 			
 			addi $v0, $zero, 1
 			move $a0, $s0
 			syscall
 			
 			addi $v0, $zero, 4
 			la $a0, new_line
 			syscall 
						
			addi $v0, $zero, 4
 			la $a0, third_minimum
 			syscall
 			
 			addi $v0, $zero, 1
 			move $a0,  $s1
 			syscall
 			
 			addi $v0, $zero, 4
 			la $a0, new_line
 			syscall 
					
			pass_10:
					
			addi $s3, $s3, 1
						
			beq $s2, $s3, jump_11
			j pass_11
			jump_11:
			jal readArray
			addi $s6, $v0, 0
			addi $s7, $v1, 0		
			pass_11:
			addi $s3, $s3, 1
			beq $s2, $s3, exit_9
			j for_9
	exit_9:
									
	# main
	li $v0, 10
 	syscall 
 	
 	
	readArray:
		# requesting length
 		addi $v0, $zero, 4
 		la $a0, request_aray_length
 		syscall 
 	
 		# getting user input
 		addi $v0, $zero, 5
 		syscall 
 	
 		# storing length
 		add $t0, $zero, $v0
 		sw $t0, array_length	
		mul $t4, $t0, 4
		
		# allocating
		add $a0, $t4, 0
		li $v0, 9 
		syscall
		
		addi $t1, $v0, 0
		addi $t2, $t1, 0
		addi $t3, $zero, 0
		
		loop_1: beq $t3, $t0, exit_1 
		
			addi $v0, $zero, 4
 	       		la $a0, request_aray_item_1
 	       		syscall 
 	       
 	       		# printing an integer
 	       		addi $v0, $zero, 1
 	       		addi $a0, $t3, 1
 	       		syscall 
 	
 	      	 	# requesting item
 	       		addi $v0, $zero, 4
 	       		la $a0, request_aray_item_2
 	       		syscall 
 	       
 	       		# getting user input
 	       		addi $v0, $zero, 5
 	       		syscall 
			
			addi $t4, $v0, 0
 			sw $t4, 0($t2) 
 			addi $t2, $t2, 4
 			addi $t3, $t3, 1
 			j loop_1
 			
 		exit_1:
 			
		addi $v0, $t1, 0 # address of the stored array
		addi $v1, $t0, 0 # size of the stored array	       	
 	       	jr $ra 
 	# readArray
 	
 	
 	display_array:
 		addi $sp, $sp, -24
 		sw $ra, 0($sp)
 		sw $s0, 4($sp)
 		sw $s1, 8($sp)
 		sw $s2, 12($sp) 
 		sw $a0, 16($sp)
 		sw $a1, 20($sp)
 		
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
 		lw $a0, 16($sp)
 		lw $a1, 20($sp)
 		addi $sp, $sp, 24
 	       	jr $ra
 	# display_array
 			 
 			 
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
 	       			
 	       			slt $t3, $zero, $t0
 	       			bne $t3, $zero, pass_20
 	       			mul $t3, $t0, -1
 	       			
 	       			j pass_21
 	       			pass_20:
 	       			move $t3, $t0
 	       			pass_21:
 	       			
 	       			slt $t4, $zero, $t1
 	       			bne $t4, $zero, pass_22
 	       			mul $t4, $t1, -1
 	       			 	       			
 	       			j pass_23
 	       			pass_22:
 	       			move $t4, $t1
 	       			pass_23:
 	       			
 	       			slt $t2, $t3, $t4
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
	# bubbleSort
	
	
	thirdMinThirdMax:
 		addi $sp, $sp, -32
 		sw $ra, 0($sp)
 		sw $s0, 4($sp)
 		sw $s1, 8($sp)
 		sw $s2, 12($sp) 
 		sw $s3, 16($sp) 
 		sw $s4, 20($sp) 
 		sw $a0, 24($sp)
 		sw $a1, 28($sp)
 		
 		move $s0, $a0 # actual array
 		move $t2, $s0 # actual array
 		move $s1, $a1 # length
 		
 		# allocating
		add $a0, $s1, 0
		li $v0, 9 
		syscall
		
		move $t0, $v0 # temp array
		move $t1, $v0 # temp array
		move $s2, $zero
		
		for_5:  beq $s2, $s1, exit_5
			lw $t3, 0($t2)
			sw $t3, 0($t1)
			addi $t2, $t2, 4 
			addi $t1, $t1, 4 		
			addi $s2, $s2, 1
			j for_5
		exit_5:
		
		move $s0, $t0 
 		move $s2, $zero
 		addi $s3, $s1, -1
		
		move $s2, $zero
 		addi $s3, $s1, -1
 		
 		for_6: 	beq $s2, $s1, exit_6
 			move $s4, $zero
 			move $s5, $s0
 			for_7:	beq $s4, $s3, exit_7 
 				lw $t0, 0($s5)
 				lw $t1, 4($s5) 		
 	       			
 	       			slt $t2, $t0, $t1
 	       			beq $t2, $zero, jump_2
 	       			move $t2, $t0
 	       			move $t0, $t1
 	       			move $t1, $t2
 	       			sw $t0, 0($s5)
 				sw $t1, 4($s5) 	
 	       			jump_2:
 	       			addi $s4, $s4, 1
 	       			addi $s5, $s5, 4
 	       			j for_7
 	       		
 	       		exit_7:
 	       		addi $s2, $s2, 1
 	       		j for_6
 	       	exit_6:

		addi $s2, $zero, 2
		addi $s3, $s1, -3
		mul $s2, $s2, 4
		mul $s3, $s3, 4
		
		move $s4, $s0
		add $s4, $s4, $s2
		lw $v0, 0($s4)
		
		move $s4, $s0
		add $s4, $s4, $s3
		lw $v1, 0($s4)
		
 	       	lw $ra, 0($sp)
 		lw $s0, 4($sp)
 		lw $s1, 8($sp)
 		lw $s2, 12($sp)
 		lw $s3, 16($sp) 
 		lw $s4, 20($sp) 
 		lw $a0, 24($sp)
 		lw $a1, 28($sp)
 		addi $sp, $sp, 32
 	       	jr $ra
	# bubbleSort
	
		
	mode:
		addi $sp, $sp, -32
 		sw $ra, 0($sp)
 		sw $s0, 4($sp)
 		sw $s1, 8($sp)
 		sw $s2, 12($sp) 
 		sw $s3, 16($sp) 
 		sw $s4, 20($sp) 
 		sw $a0, 24($sp)
 		sw $a1, 28($sp)
 		
 		
 		move $s0, $a0 # array
 		addi $s1, $a1, -1 # length
 		move $s3, $zero # max
 		addi $s4, $zero, 1 # temp
 		move $s5, $zero # index
 		move $t5, $zero
 		 		 		
 		for_8: 	beq $s5, $s1, exit_8
 			lw $t0, 0($s0)
 			lw $t1, 4($s0)
 			bne $t0, $t1, jump_3
 			addi $s4, $s4, 1
 			addi $t7, $s5, 1
 			beq $t7, $s1, jump_3	
 			j jump_5
 			jump_3:
 			slt $t2, $s4, $s3
 			bne $t2, $zero, jump_4
 			beq $s3, $s4, jump_6
 			move $s3, $s4
 			lw $t5, 0($s0)
 			j pass_12
 			jump_6:
 			lw $t6, 0($s0)
 			slt $t7, $t5, $t6 
 			bne $t7, $zero, pass_12
 			lw $t5, 0($s0)
 			pass_12:
 			addi $s4, $zero, 1
 			jump_4:
 			jump_5:
 			addi $s0, $s0, 4
 			addi $s5, $s5, 1
 			j for_8
 		exit_8:
 		
 		
 		addi $t7, $zero, 1
 		bne $s3, $t7, pass_26
 		lw $t5, 0($s0)
 		pass_26:
 		
 		move $v0, $t5
		
 	       	lw $ra, 0($sp)
 		lw $s0, 4($sp)
 		lw $s1, 8($sp)
 		lw $s2, 12($sp)
 		lw $s3, 16($sp) 
 		lw $s4, 20($sp) 
 		lw $a0, 24($sp)
 		lw $a1, 28($sp)
 		addi $sp, $sp, 32
 	       	jr $ra
	  # mode	
		
 	
 	
