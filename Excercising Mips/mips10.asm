.data
	sum:       .asciiz "Sum: "
	new_line:  .asciiz "\n"
	num_array: .space  400
.text
	main:
		move $s0, $zero, 
		addi $s1, $zero, 101 
		move $s2, $zero, 
			
		for_1: slt $t0, $s0, $s1
		       beq $t0, $zero, for_exit_1
		       jal print_value
		       jal goto_new_line
		       add  $s2, $s2, $s0
		       addi $s0, $s0, 1
		       j for_1
		  
		for_exit_1:
		       # sum
 		       li $v0, 4
 	               la $a0, sum
 	               syscall 
 	               
 	               li $v0, 1
 		       move $a0, $s2
 	               syscall 
 					
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
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	