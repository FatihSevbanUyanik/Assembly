.data
	array: .space 80
	reversed_array: .space 80
	array_size: .word 20
	array_length: .word 0
	request_aray_length: .asciiz "Please enter the length of the array: "
	request_aray_item_1: .asciiz "Please enter the "
	request_aray_item_2: .asciiz " item: "
	content_of_array: .asciiz "Array Content: "
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

	# Reversing array
 	addi $v0, $zero, 4
 	la $a0, new_line
	syscall 
	
 	addi $t0, $zero, 0
	addi $t1, $zero, 0
	lw $t4, array_length
	addi $t4, $t4, -1
	mul $t4, $t4, 4
	 	
	j check_3
	 	
 	for_3: addi $t0, $t0, 1
 	       lw $t5, array($t1) 
 	       addi $t1, $t1, 4 
 	       
 	       sw $t5, reversed_array($t4)
 	       addi $t4, $t4, -4
 	       
 	       check_3: bne $t0, $t3, for_3
 	       
 	addi $t0, $zero, 0
	addi $t1, $zero, 0 	
	j check_4
	
	# copying reversed array 
	# contents to actual array
 	for_4: addi $t0, $t0, 1
 	       lw $t5, reversed_array($t1) 
 	       sw $t5, array($t1)
 	       addi $t1, $t1, 4 
 	       check_4: bne $t0, $t3, for_4
 	
 	
 	# Displaying array
 	addi $v0, $zero, 4
 	la $a0, content_of_array
 	syscall 
 	
 	addi $t0, $zero, 0
	addi $t1, $zero, 0
 	
 	j check_5
 	
 	for_5: addi $t0, $t0, 1
 	       lw $t5, reversed_array($t1) 
 	       addi $t1, $t1, 4 
 	              
 	       # printing an integer
 	       addi $v0, $zero, 1
 	       addi $a0, $t5, 0
 	       syscall 
 	
 	       addi $v0, $zero, 4
 	       la $a0, add_space
 	       syscall 
 	       
 	       check_5: bne $t0, $t3, for_5

 	addi $v0, $zero, 4
 	la $a0, new_line
	syscall 
	
