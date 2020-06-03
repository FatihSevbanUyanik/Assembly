.data
	num_array: .space  400 # 100:3
	new_line:  .byte '\n'
.text
	main:
		move $s0, $zero 
		addi $s1, $zero, 101 
		move $t0, $zero
			
		for_1: slt $t1, $s0, $s1
		       beq $t1, $zero, for_exit_1
		       sw  $s0, num_array($t0)
		       addi $s0, $s0, 1
		       addi $t0, $t0, 4
		       j for_1
		  
		for_exit_1:
		 	        
 	        move $s0, $zero 
		addi $s1, $zero, 101 
		move $t0, $zero
		
		for_2: slt $t1, $s0, $s1
		       beq $t1, $zero, for_exit_2
		       lw  $t3, num_array($t0)
		       addi $s0, $s0, 1
 	               addi $t0, $t0, 4
		       li $v0, 1
 		       move $a0, $t3
 		       syscall 
		       li $v0, 4
		       la $a0, new_line
 		       syscall 
 	               j for_2
 	        
 	      for_exit_2:
 					
	# main
	li $v0, 10
 	syscall 
 			
  	goto_new_line:
 		li $v0, 4
		la $a0, new_line
 		syscall 
 		jr $ra
 	# goto_new_line
 	
 	print_value:
 		# allocating memory
 		addi $sp, $sp, -4
 		sw $s0, 0($sp)
 		
 		# printing 
 		li $v0, 1
 		move $a0, $s0
 		syscall 
 				
 		# deallocate
 		lw $s0, 0($sp)
  		addi $sp, $sp, 4
  		jr $ra
  	# print_value
 	
 	