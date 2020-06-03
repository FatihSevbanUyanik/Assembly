.data
	option_1_create_matrix:    .asciiz "1 --> Create matrix\n"
	option_2_retrieve_item:    .asciiz "2 --> Retrieve Item\n"
	option_3_row_by_row_sum:   .asciiz "3 --> Row by row Sum\n"
	option_4_col_by_col_sum:   .asciiz "4 --> Col by col Sum\n"
	option_5_display_matrix:   .asciiz "5 --> Display Matrix\n"	
	option_6_display_row_col:  .asciiz "6 --> Display row and column\n"
	option_7_create_automatic: .asciiz "7 --> Create matrix and fill automatic\n"
	option_8_exit: .asciiz "8 --> Exit\n"
	request_matrix_size: .asciiz "Enter matrix size: "
	request_entry: .asciiz "Please enter item at "
	request_option: .asciiz "Please select an option: "
	request_row: .asciiz "Please select row index: "
	request_col: .asciiz "Please select col index: "	 
	paranthesis_left: .asciiz "("
	paranthesis_right: .asciiz ")"
	comma: .asciiz ","
	row: .asciiz "ROW: "
	col: .asciiz "COL: "
	space: .asciiz " "
	two_dots: ": "
	new_line: .asciiz "\n"	
	divider: .asciiz "--------------------------------------------------------------\n"
.text
	main:
		while: 
			jal print_interface
			
			la $a0, request_option
			li $v0, 4
			syscall 
			
			# getting user input
 			addi $v0, $zero, 5
 			syscall 
 			move $s6, $v0
			
			option_1: bne $s6, 1, option_2	
			jal create_matrix
			move $s0, $v0 # size of matrix
			move $s1, $v1 # address of matrix
			
			option_2: bne $s6, 2, option_3	
			move $a0, $s0
			move $a1, $s1	
				
			la $a0, request_row
			li $v0, 4
			syscall
			
			# getting user input
 			addi $v0, $zero, 5
 			syscall 
			move $a2, $v0 
			
			la $a0, request_col
			li $v0, 4
			syscall
			
			# getting user input
 			addi $v0, $zero, 5
 			syscall 
			move $a3, $v0 		
			jal retrieve_item
			
			option_3: bne $s6, 3, option_4	
			move $a0, $s0
			move $a1, $s1
			jal sum_row_by_row
			
			option_4: bne $s6, 4, option_5	
			move $a0, $s0
			move $a1, $s1
			jal sum_col_by_col
			
			option_5: bne $s6, 5, option_6	
			move $a0, $s0
			move $a1, $s1
			jal display_matrix
			
			option_6: bne $s6, 6, option_7
			la $a0, request_row
			li $v0, 4
			syscall
			move $a2, $v0 
			
			# getting user input
 			addi $v0, $zero, 5
 			syscall 
			move $a2, $v0 
			
			la $a0, request_col
			li $v0, 4
			syscall
			
			# getting user input
 			addi $v0, $zero, 5
 			syscall 
			move $a3, $v0 
			
			move $a0, $s0
			move $a1, $s1	
			jal display_row_and_col
			
			option_7: bne $s6, 7, option_8
			jal create_matrix_automatic
			move $s0, $v0 # size of matrix
			move $s1, $v1 # address of matrix
			
			option_8: beq $s6, 8, exit
			j while		
		exit:
		
	# main
	li $v0, 10
 	syscall 
	
	print_interface:
		la $a0, divider
		li $v0, 4
		syscall
		
		la $a0, option_1_create_matrix
		li $v0, 4
		syscall 
	
		la $a0, option_2_retrieve_item
		li $v0, 4
		syscall
	
		la $a0, option_3_row_by_row_sum
		li $v0, 4
		syscall
	
		la $a0, option_4_col_by_col_sum
		li $v0, 4
		syscall
	
		la $a0, option_5_display_matrix
		li $v0, 4
		syscall
		
		la $a0, option_6_display_row_col
		li $v0, 4
		syscall
		
		la $a0, option_7_create_automatic
		li $v0, 4
		syscall
		
		la $a0, option_8_exit
		li $v0, 4
		syscall
		
		la $a0, divider
		li $v0, 4
		syscall
	# print_interface
	jr $ra
	

	display_row_and_col:
	addi $sp, $sp, -32
 	sw $ra, 0($sp)
 	sw $s0, 4($sp)
 	sw $s1, 8($sp)
 	sw $s2, 12($sp) 
 	sw $s3, 16($sp)
 	sw $s4, 20($sp)
  	sw $s5, 24($sp)  	
 	sw $s6, 28($sp)
 		
 		move $s0, $a0 # size
 		move $s1, $a1 # address of array
		move $s2, $a2 # row
		move $s3, $a3 # col
		
		mul $t0, $s0, 4
 		mul $t0, $t0, $s2	
		add $t1, $t0, $s1
		move $s4, $zero
		
		la $a0, row
		li $v0, 4
		syscall
		
		loop_9: beq $s4, $s0, exit_9
			lw $s5, 0($t1)
					
			move $a0, $s5
			li $v0, 1
			syscall
			
			la $a0, space
			li $v0, 4
			syscall
		   	
		   	addi $s4, $s4, 1
			addi $t1, $t1, 4
			j loop_9
			exit_9:
			
		la $a0, new_line
		li $v0, 4
		syscall
		
		mul $s5, $s0, 4
 		mul $t0, $s3, 4
 		add $t0, $t0, $s1 
		move $s4, $zero
		
		la $a0, col
		li $v0, 4
		syscall
		
		loop_10: beq $s4, $s0, exit_10
			 lw $s6, 0($t0)
			 	 
			 move $a0, $s6
			 li $v0, 1
			 syscall
			 
			 la $a0, space
			 li $v0, 4
			 syscall
		   	 
		   	 addi $s4, $s4, 1
			 add $t0, $t0, $s5
			 j loop_10
			 exit_10:
		
		la $a0, new_line
		li $v0, 4
		syscall
		
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
	# sum_row_by_row
	
	
	retrieve_item:
	addi $sp, $sp, -32
 	sw $ra, 0($sp)
 	sw $s0, 4($sp)
 	sw $s1, 8($sp)
 	sw $s2, 12($sp) 
 	sw $s3, 16($sp)
 	sw $s4, 20($sp)
  	sw $s5, 24($sp)  	
 	sw $s6, 28($sp)
 		
 		move $s0, $a0 # size
 		move $s1, $a1 # address of array
		move $s2, $a2 # row
		move $s3, $a3 # col
		
		mul $t0, $s0, 4
 		mul $t0, $t0, $s2
 		mul $t1, $s3, 4
 		add $t0, $t0, $t1
 		add $t1, $t0, $s1
		lw $s4, 0($t1)
		
		move $a0, $s4
		li $v0, 1
		syscall
			
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
	
	
	sum_col_by_col:
	addi $sp, $sp, -32
 	sw $ra, 0($sp)
 	sw $s0, 4($sp)
 	sw $s1, 8($sp)
 	sw $s2, 12($sp) 
 	sw $s3, 16($sp)
 	sw $s4, 20($sp)
  	sw $s5, 24($sp)  	
 	sw $s6, 28($sp)
 		
 		move $s0, $a0 # size
 		move $s1, $a1 # address of array
		move $s2, $zero
		move $s3, $zero	

		loop_7: beq $s3, $s0, exit_7 
			move $s6, $zero
			loop_8: beq $s2, $s0, exit_8 
				mul $t0, $s0, 4
 				mul $t0, $t0, $s2
 				mul $t1, $s3, 4
 				add $t0, $t0, $t1
 				add $t1, $t0, $s1
				lw $s4, 0($t1)
				add $s6, $s6, $s4
 				addi $s2, $s2, 1
			j loop_8
			exit_8:
			
			move $s2, $zero	
			addi $s3, $s3, 1
			
			move $a0, $s6
			li $v0, 1
			syscall
			
			la $a0, space
			li $v0, 4
			syscall
			j loop_7
			exit_7:
			
			la $a0, new_line
			li $v0, 4
			syscall
			
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
	# sum_col_by_col
	
	
	sum_row_by_row:
	addi $sp, $sp, -32
 	sw $ra, 0($sp)
 	sw $s0, 4($sp)
 	sw $s1, 8($sp)
 	sw $s2, 12($sp) 
 	sw $s3, 16($sp)
 	sw $s4, 20($sp)
  	sw $s5, 24($sp)  	
 	sw $s6, 28($sp)
 		
 		move $s0, $a0 # size
 		move $s1, $a1 # address of array
		move $s2, $zero
		move $s3, $zero	

		loop_1: beq $s2, $s0, exit_1 
			move $s6, $zero
			loop_2: beq $s3, $s0, exit_2 
				mul $t0, $s0, 4
 				mul $t0, $t0, $s2
 				mul $t1, $s3, 4
 				add $t0, $t0, $t1
 				add $t1, $t0, $s1
				lw $s4, 0($t1)
				add $s6, $s6, $s4
 				addi $s3, $s3, 1
			j loop_2
			exit_2:
			
			move $s3, $zero	
			addi $s2, $s2, 1
			
			move $a0, $s6
			li $v0, 1
			syscall
			
			la $a0, new_line
			li $v0, 4
			syscall
			j loop_1
			exit_1:
			
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
	# sum_row_by_row
	
	
	display_matrix:
	addi $sp, $sp, -32
 	sw $ra, 0($sp)
 	sw $s0, 4($sp)
 	sw $s1, 8($sp)
 	sw $s2, 12($sp) 
 	sw $s3, 16($sp)
 	sw $s4, 20($sp)
  	sw $s5, 24($sp)  	
 	sw $s6, 28($sp)
 		
 		move $s0, $a0 # size
 		move $s1, $a1 # address of array
		move $s2, $zero
		move $s3, $zero	

		loop_5: beq $s2, $s0, exit_5 
			loop_6: beq $s3, $s0, exit_6 
				
				mul $t0, $s0, 4
 				mul $t0, $t0, $s2
 				mul $t1, $s3, 4
 				add $t0, $t0, $t1
 				add $t1, $t0, $s1
				lw $s4, 0($t1)
				
				move $a0, $s4
				li $v0, 1
				syscall
			
				li $v0, 4
 				la $a0, space
 				syscall 
 				addi $s3, $s3, 1
			j loop_6
			exit_6:
			
			move $s3, $zero	
			addi $s2, $s2, 1	
			la $a0, new_line
			li $v0, 4
			syscall
			j loop_5
			exit_5:
			
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
	# display_matrix
	
	
	create_matrix:
	addi $sp, $sp, -32
 	sw $ra, 0($sp)
 	sw $s0, 4($sp)
 	sw $s1, 8($sp)
 	sw $s2, 12($sp) 
 	sw $s3, 16($sp)
 	sw $s4, 20($sp)
  	sw $s5, 24($sp)  	
 	sw $s6, 28($sp)
	
		li $v0, 4
 		la $a0, request_matrix_size
 		syscall 
	
		# getting user input
 		addi $v0, $zero, 5
 		syscall 
 		
 		move $s0, $v0
 		mul $s5, $s0, $s0
 		mul $s5, $s5, 4
 		
 		move $a0, $s5
		li $v0, 9
		syscall

		move $s1, $v0
		move $s2, $zero
		move $s3, $zero	

		loop_3: beq $s2, $s0, exit_3 
			loop_4: beq $s3, $s0, exit_4 
				la $a0, request_entry
				li $v0, 4
				syscall 
			
				beq $s3, $s0, exit_2 
				la $a0, paranthesis_left
				li $v0, 4
				syscall 
			
				move $a0, $s2
				li $v0, 1
				syscall
			
				li $v0, 4
 				la $a0, comma
 				syscall 
	
				move $a0, $s3
				li $v0, 1
				syscall
				
				li $v0, 4
 				la $a0, paranthesis_right
 				syscall 
			
				li $v0, 4
 				la $a0, two_dots
 				syscall 
			
				# getting user input
 				addi $v0, $zero, 5
 				syscall 
 				
 				move $s4, $v0
 				
 				mul $t0, $s0, 4
 				mul $t0, $t0, $s2
 				mul $t1, $s3, 4
 				add $t0, $t0, $t1
 				add $t1, $t0, $s1
				sw $s4, 0($t1)
				addi $s3, $s3, 1
				
			j loop_4
			exit_4:
			
			move $s3, $zero	
			addi $s2, $s2, 1	
			j loop_3
			exit_3:
			
			move $v0, $s0
			move $v1, $s1	
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
	# create_matrix
	
	create_matrix_automatic:
	addi $sp, $sp, -32
 	sw $ra, 0($sp)
 	sw $s0, 4($sp)
 	sw $s1, 8($sp)
 	sw $s2, 12($sp) 
 	sw $s3, 16($sp)
 	sw $s4, 20($sp)
  	sw $s5, 24($sp)  	
 	sw $s6, 28($sp)
	
		li $v0, 4
 		la $a0, request_matrix_size
 		syscall 
	
		# getting user input
 		addi $v0, $zero, 5
 		syscall 
 		
 		move $s0, $v0
 		mul $s5, $s0, $s0
 		mul $s5, $s5, 4
 		
 		move $a0, $s5
		li $v0, 9
		syscall

		move $s1, $v0
		move $s2, $zero
		move $s3, $zero	
		move $s4, $zero

		loop_11: beq $s2, $s0, exit_11 
			loop_12: beq $s3, $s0, exit_12 				
 				mul $t0, $s0, 4
 				mul $t0, $t0, $s2
 				mul $t1, $s3, 4
 				add $t0, $t0, $t1
 				add $t1, $t0, $s1
				sw $s4, 0($t1)
				addi $s3, $s3, 1
				addi $s4, $s4, 1
			j loop_12
			exit_12:
			
			move $s3, $zero	
			addi $s2, $s2, 1	
			j loop_11
			exit_11:
			
			move $v0, $s0
			move $v1, $s1	
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
	# create_matrix
	
