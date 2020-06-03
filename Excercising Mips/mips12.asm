.data
	request_number: .asciiz "Please type a number: "
	result_message: .asciiz "Result: "
	number: .word 0
	answer: .word 0
.text
# =================================================================================
	main:
		# requesting number
		li $v0, 4
		la $a0, request_number
		syscall
	
		# getting number
 		li $v0, 5
 		syscall 
		
		# store number
		sw $v0, number
		
		lw $a0, number
		jal take_factorial
		sw $v0, answer
	
		# outputting result
		li $v0, 4
		la $a0, result_message
		syscall
	
		li $v0, 1
 		lw $a0, answer
 		syscall 
 	
 	# main
	li $v0, 10
 	syscall 
 # =================================================================================
 	
 	take_factorial: 
 		addi $sp, $sp, -8
 		sw $ra, 0($sp)
 		sw $s0, 4($sp)
 		
 		li $v0, 1
 		beq $a0, $v0, done
 		  move $s0, $a0
 		  addi $a0, $a0, -1
 		  jal take_factorial
 		  mul $v0, $s0, $v0
 		
 		done:
 		lw $ra, 0($sp)
 		lw $s0, 4($sp)
 		addi $sp, $sp, 8
 		jr $ra
 		
 # =================================================================================

	