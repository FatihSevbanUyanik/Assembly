.data
	new_line: .asciiz "\n"
.text
	main:
		addi $s0, $zero, 10
		jal increase_reg_s0
		jal goto_new_line
		jal print_value
		
	# main
	li $v0, 10
 	syscall 
 	
 	increase_reg_s0:
 		# allocating memory
 		addi $sp, $sp, -8
 		sw $s0, 0($sp)
 		sw $ra, 4($sp)
 		
 		# incrementing
 		addi $s0, $s0, 10
 		jal print_value
 		lw $ra, 4($sp)
 		
 		# restore and deallocate
 		lw $s0, 0($sp)
  		addi $sp, $sp, 8
  		jr $ra
  	# increase_reg_s0
  		
  	goto_new_line:
 		li $v0, 4
 		la $a0, new_line
 		syscall 
 		jr $ra
 	# goto_new_line
 	
 	print_value:
 		# print s0
		li $v0, 1
		move $a0, $s0
		syscall
		jr $ra
 	# print_value

 		
 		
 		
 	
 	
 	
 	
 	