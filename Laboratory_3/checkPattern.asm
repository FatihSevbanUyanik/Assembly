.data 
	request_input_bit: .asciiz "Please enter 32 bit number (Please type 1 and 0): "
	input_bit: .space 40            
	request_pattern_length: .asciiz "Please enter search pattern length: "
	request_search_pattern: .asciiz "Please enter search pattern (Please type 1 and 0): "
	search_pattern: .space 40   
	result: .asciiz "Result: " 
	new_line: .asciiz "\n"
.text

	li $v0, 4
 	la $a0, request_input_bit
 	syscall 

	li $v0, 8          
    	la $a0, input_bit  
    	li $a1, 40         
    	syscall
    	
    	
    	la $s1, input_bit
    	move $s7, $zero
    	
    	
    	loop_2: beq $s1, $zero, exit_2
    		
    		lbu $t1, 0($s1)
    		addi 
    		
    		li $v0, 1
 		la $a0, input_bit($s1)
 		syscall 
    		
    	
    	

	li $v0, 4
 	la $a0, request_pattern_length
 	syscall 
 	
 	# getting user input
 	addi $v0, $zero, 5
 	syscall 																				
	move $s0, $v0	
 	
 	li $v0, 4
 	la $a0, request_search_pattern
 	syscall 
 	
 	li $v0, 8               
    	la $a0, search_pattern  
      	addi $a1, $s0, 2  
    	syscall

	la $a0, search_pattern
	la $a1, input_bit
	add, $a2, $zero, $s0
	jal checkPattern
	
	move $t1, $v0
	
	li $v0, 4
 	la $a0, result
 	syscall 
	
	li $v0, 1
 	move $a0, $t1
 	syscall 
	
	# main
	li $v0, 10
 	syscall 
	

checkPattern:
	addi $sp, $sp, -32
 	sw $ra, 0($sp)
 	sw $s0, 4($sp)
 	sw $s1, 8($sp)
 	sw $s2, 12($sp) 
 	sw $s3, 16($sp)
 	sw $s4, 20($sp)
  	sw $s5, 24($sp)  	
  	sw $s6, 28($sp)

	addi $s0, $a0, 2    # search pattern
	addi $s1, $a1, 31   # bit inputs
	move $s2, $a2       # n 
	move $s3, $s0       # search pattern copy
	move $s4, $zero     # iterator
	move $t7, $zero     # three count
	move $t5, $zero     # count
	
	loop_1: bgt $s4, 32, exit_1
		lbu $s5, 0($s0)
		lbu $s6, 0($s1)
		
		# if
		bne $s5, $s6, else_1
		   addi $t7, $t7, 1
		# else
		j jump_1
		else_1:  
		   sub $t0, $s2, $t7 
		   sub $s1, $s1, $t0
		   move $t7, $zero
		   move $s0, $s3
		   add $s4, $s4, $t0
		   j loop_1
		jump_1:
	
		# is matching
		bne $t7, 3, jump_2
		move $t7, $zero
		addi $t5, $t5, 1
		move $s0, $s3
		
		addi $s1, $s1, -1	
		addi $s4, $s4, 1
		j loop_1
		jump_2:
		
		addi $s0, $s0, -1
		addi $s1, $s1, -1	
		addi $s4, $s4, 1
		j loop_1
	exit_1:
		
	move $v0, $t5
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
