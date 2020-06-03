.data
	message: .asciiz "My Message.\n"
.text
	main:
		jal display_message	
		
		addi $a0, $zero, 50
		addi $a1, $zero, 80
		jal add_numbers	
		
 		la $v0, 1
 		move $a0, $v1
 		syscall 
 			
	# main
	li $v0, 10
 	syscall 
 	
 	
 	display_message:
 		li $v0, 4
 		la $a0, message
 		syscall 
 		jr $ra 
 	# display_message
 	
 	add_numbers:
 		add $v1, $a0, $a1 
 		jr $ra 
 	# add_numbers		