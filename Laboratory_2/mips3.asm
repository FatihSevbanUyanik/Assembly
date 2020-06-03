.data
	request_aray_length: .asciiz "Please enter the length of the array: "
	request_aray_item_1: .asciiz "Please enter the "
	request_aray_item_2: .asciiz " item: "	
	array_length: .word 0
	add_space: .asciiz "  "

.text
	main:
	
		jal readArray
		
		addi $t2, $v0, 0
		addi $t3, $zero, 0
		
		loop_2: lw $t4, 0($t2)
 			beq $t4, $zero, exit_2
 			
 			# printing an integer
 	       		addi $v0, $zero, 1
 	       		addi $a0, $t4, 0
 	       		syscall 
 	
 	       		addi $v0, $zero, 4
 	       		la $a0, add_space
 	       		syscall 
 	        
 	       		addi $t2, $t2, 4
 	       		j loop_2
		exit_2:
		
	
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
 			 
 			  
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		