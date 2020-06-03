.data
	array: .space 80
	array_size: .word 20
	array_length: .word 0
	request_aray_length: .asciiz "Please enter the length of the array: "
	request_aray_item_1: .asciiz "Please enter the "
	request_aray_item_2: .asciiz " item: "
	content_of_array: .asciiz "Array Content: "
	not_palindrome: .asciiz "The array is not a palindrome."
	is_palindrome: .asciiz "The array is a palindrome."
	add_space: "  "
	new_line: "\n"
	
.text
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	lw $t2, array_size
		
	# requesting length
 	addi $v0, $zero, 4
 	la $a0, request_aray_length
 	syscall 
 	
 	# getting user input
 	addi $v0, $zero, 5
 	syscall 
 	
 	# storing length
 	add $t3, $zero, $v0
 	sw $t3, array_length
 	
 	j check_1
 	
	# requesting items
 	for_1: addi $t0, $t0, 1 

 	       addi $v0, $zero, 4
 	       la $a0, request_aray_item_1
 	       syscall 
 	       
 	       # printing an integer
 	       addi $v0, $zero, 1
 	       addi $a0, $t0, 0
 	       syscall 
 	
 	       # requesting item
 	       addi $v0, $zero, 4
 	       la $a0, request_aray_item_2
 	       syscall 
 	       
 	       # getting user input
 	       addi $v0, $zero, 5
 	       syscall 
 	       
 	       sw $v0, array($t1) 
 	       addi $t1, $t1, 4 
 	       
 	       check_1: bne $t0, $t3, for_1
 	       
 	addi $v0, $zero, 4
 	la $a0, content_of_array
 	syscall 
 	
 	addi $t0, $zero, 0
	addi $t1, $zero, 0
 	
 	j check_2
 	
 	# Displaying array
 	for_2: addi $t0, $t0, 1
 	       lw $t5, array($t1) 
 	       addi $t1, $t1, 4 
 	              
 	       # printing an integer
 	       addi $v0, $zero, 1
 	       addi $a0, $t5, 0
 	       syscall 
 	
 	       addi $v0, $zero, 4
 	       la $a0, add_space
 	       syscall 
 	       
 	       check_2: bne $t0, $t3, for_2
 	       
 	addi $v0, $zero, 4
 	la $a0, new_line
	syscall 

	addi $s0, $zero, 0
	lw $s1, array_length
	addi $s1, $s1, -1
	la $t0, array
	mul $t1, $s1, 4
	add $t1, $t1, $t0
	
	j check_3
	
	# Displaying array
 	for_3: addi $s0, $s0, 1
 	       addi $s1, $s1, -1
 	       
 	       lw $t4, 0($t0)
 	       lw $t5, 0($t1)
 	       
 	       addi $t0, $t0, 4
 	       addi $t1, $t1, -4 	
 	       
 	       bne $t4, $t5, non_palindrome 
 	              
 	       check_3: slt $t3, $s0, $s1
 	       		bne $t3, $zero, for_3
 	 		
 	addi $v0, $zero, 4
 	la $a0, is_palindrome
 	syscall 
			
	j exit_1
	
	non_palindrome: addi $v0, $zero, 4
 	       		la $a0, not_palindrome
 	       		syscall 
 	       
	exit_1:
