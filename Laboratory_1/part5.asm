.data
	array: .space 400
	array_size: .word 100
	array_length: .word 0
	request_aray_length: .asciiz "Please enter the length of the array: "
	request_aray_item_1: .asciiz "Please enter the "
	request_aray_item_2: .asciiz " item: "
	request_input_number: .asciiz "Please enter an input number: "
	represent_result: .asciiz "Result: "
	content_of_array: .asciiz "Array Content: "
	menu: .asciiz "MENU"
	option_1: .asciiz "1. Find summation of numbers stored in the array which is less than an input number."
	option_2: .asciiz "2. Find summation of numbers out of a value range specified by two numbers and display that value."
	option_3: .asciiz "3. Display the number of occurrences of the array elements divisible by a certain input number."
	option_4: .asciiz "4. Quit."
	decision: .asciiz "Please make a decision: "
	add_space: "  "
	new_line: "\n"
	quit: "Program Excited"
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
 	
 		addi $v0, $zero, 4
 	       	la $a0, new_line
 	       	syscall
 		
 		loop:
 		
 		# display menu
 		jal display_menu
 		
 	       	addi $v0, $zero, 4
 	       	la $a0, new_line
 	       	syscall
 	
 	       	addi $v0, $zero, 4
 	       	la $a0, decision
 	       	syscall
 	       	
 	       	# getting decision
 	       	addi $v0, $zero, 5
 	       	syscall 
 	       	
		la $s2, array
 		addi $a1, $s2, 0
  		addi $a2, $s3, 0	
 	       
 	       	
 	       	addi $s4, $v0, 0
 	       	addi $s5, $zero, 1
 	    	
 	    	beq $s4, $s5, opt_1
 	    	addi $s5, $s5, 1
 	    	beq $s4, $s5, opt_2
 	    	addi $s5, $s5, 1
 	    	beq $s4, $s5, opt_3
 	    	addi $s5, $s5, 1
 	    	beq $s4, $s5, opt_4
 	    	
 	    	j jump1
 	    	opt_1: jal func_option_1
 	    	j show_result
		jump1:
		
		j jump2
 	    	opt_2: jal func_option_2
 	    	j show_result
 	    	jump2:
 	    	
 	    	j jump3
 	    	opt_3: jal func_option_3 
 	    	j show_result
 	    	jump3:	    	
 	    	
 	    	j result
 	    	show_result:
 	    	move $s6, $v0
 	    	
 	    	addi $v0, $zero, 4
 	       	la $a0, represent_result
 	       	syscall
 	    	
 		addi $v0, $zero, 1
 	       	addi $a0, $s6, 0
 	       	syscall
 	       	
 	       	addi $v0, $zero, 4
 	       	la $a0, new_line
 	       	syscall
 	       	
 	       	addi $v0, $zero, 4
 	       	la $a0, new_line
 	       	syscall
 	       	result:
 	       	
 	       	j loop
 	       	
 	       	j quit_program
 	       	opt_4:
 	       	addi $v0, $zero, 4
 	       	la $a0, quit
 	       	syscall
 	       	
 	       	quit_program:
 	       	
 	       	
 	       	 
 	# main
	li $v0, 10
 	syscall 
 	
 	func_option_3:
	 	addi $sp, $sp, -24
 		sw $ra, 0($sp)
 		sw $s0, 4($sp)
 		sw $s1, 8($sp)
 		sw $s2, 12($sp) 
 		sw $s3, 16($sp) 
 		sw $s4, 20($sp)  		
 		
 		addi $v0, $zero, 4
 	       	la $a0, new_line
 	       	syscall
 	       	
 	       	addi $v0, $zero, 4
 	       	la $a0, request_input_number
 	       	syscall
 		
 		# getting user input
 	       	addi $v0, $zero, 5
 	       	syscall 
 	
 		move $s0, $v0   # input
  		move $s1, $zero # index
 		move $s2, $a1   # array
 		move $s3, $a2   # array length
 		move $s4, $zero # summation
 		
 		while_3: beq $s1, $s3, exit_5 
 			 lw $t0, 0($s2) 			 
 			 addi $s2, $s2, 4
 			 addi $s1, $s1, 1
 			 
 			 div $t1, $t0, $s0
			 mul $t2, $t1, $s0
			 sub $t0, $t0, $t2 
 			 
 			 beq $t0, $zero, jump7
 			 addi $s4, $s4, 1
 			 jump7:
 			 j while_3
 		exit_5:
 		move $v0, $s4
 		
 	       	lw $ra, 0($sp)
 		lw $s0, 4($sp)
 		lw $s1, 8($sp)
 		lw $s2, 12($sp)
  		lw $s3, 16($sp)
 		addi $sp, $sp, 16
 		
 	       	jr $ra
 	# func_option_3
 	
 	
 	func_option_1:
	 	addi $sp, $sp, -24
 		sw $ra, 0($sp)
 		sw $s0, 4($sp)
 		sw $s1, 8($sp)
 		sw $s2, 12($sp) 
 		sw $s3, 16($sp) 
 		sw $s4, 20($sp)  		
 		
 		addi $v0, $zero, 4
 	       	la $a0, new_line
 	       	syscall
 	       	
 	       	addi $v0, $zero, 4
 	       	la $a0, request_input_number
 	       	syscall
 		
 		# getting user input
 	       	addi $v0, $zero, 5
 	       	syscall 
 	
 		move $s0, $v0   # input
  		move $s1, $zero # index
 		move $s2, $a1   # array
 		move $s3, $a2   # array length
 		move $s4, $zero # summation
 		
 		while_2: beq $s1, $s3, exit_4 
 			 lw $t0, 0($s2) 			 
 			 addi $s2, $s2, 4
 			 addi $s1, $s1, 1
 			 		 
 			 slt $t1, $t0, $s0
 			 beq $t1, $zero, jump6
 			 add $s4, $s4, $t0
 			 jump6:
 			 j while_2
 		exit_4:
 		move $v0, $s4
 		
 	       	lw $ra, 0($sp)
 		lw $s0, 4($sp)
 		lw $s1, 8($sp)
 		lw $s2, 12($sp)
  		lw $s3, 16($sp)
  		lw $s4, 20($sp)
  		addi $sp, $sp, 24
 	       	jr $ra
 	# func_option_1
 	
 	
 	func_option_2:
 	       	addi $sp, $sp, -28
 		sw $ra, 0($sp)
 		sw $s0, 4($sp)
 		sw $s1, 8($sp)
 		sw $s2, 12($sp) 
 		sw $s3, 16($sp) 
 		sw $s4, 20($sp)
 		sw $s5, 24($sp)  		
 		
 		addi $v0, $zero, 4
 	       	la $a0, new_line
 	       	syscall
 	       	
 	       	addi $v0, $zero, 4
 	       	la $a0, request_input_number
 	       	syscall
 	       	
 	       	# getting user input
 	       	addi $v0, $zero, 5
 	       	syscall 
 		
 		move $s0, $v0   # input1
 		
 		addi $v0, $zero, 4
 	       	la $a0, request_input_number
 	       	syscall
 	       	
 	       	# getting user input
 	       	addi $v0, $zero, 5
 	       	syscall 
 		
 		move $s1, $v0   # input2
 		
  		move $s2, $zero # index
 		move $s3, $a1   # array
 		move $s4, $a2   # array length
 		move $s5, $zero # summation
 		
 		while_1: beq $s2, $s4, exit_3 
 			 lw $t0, 0($s3) 			 
 			 addi $s3, $s3, 4
 			 addi $s2, $s2, 1
 			 
 			 slt $t1, $t0, $s1
 			 slt $t2, $s0, $t0
 			 and $t3, $t1, $t2
 			 beq $t3, $zero, jump5
 			 add $s5, $s5, $t0
 			 jump5:
 			 j while_1
 		exit_3:
 		move $v0, $s5
 		
 	       	lw $ra, 0($sp)
 		lw $s0, 4($sp)
 		lw $s1, 8($sp)
 		lw $s2, 12($sp)
  		lw $s3, 16($sp)
 		addi $sp, $sp, 16
 		
 	       	jr $ra
 	# func_option_2
 	
 	
 	
 	
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
 	
 	
 	display_menu:
 		addi $v0, $zero, 4
 	       	la $a0, menu
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
 	       	
 	       	jr $ra
 	# display_menu
 	
 
 	
 	
