.data
	dividend: .word 0
	divisor: .word 0
	request_dividend: .asciiz "Please enter the dividend number : "
	request_divisor:  .asciiz "Please enter the divisor number : "
	represent_quotient: .asciiz "Quotient : "
	represent_remainder: .asciiz "Remainder : "
	new_line: "\n"
	
.text

 	# requesting dividend
 	addi $v0, $zero, 4
 	la $a0, request_dividend
 	syscall 
 	       
	# getting dividend
 	addi $v0, $zero, 5
 	syscall 

	# storing dividend
 	add $t0, $zero, $v0
 	sw $t0, dividend
	
	# requesting divisor
 	addi $v0, $zero, 4
 	la $a0, request_divisor
 	syscall 
 	       
	# getting divisor
 	addi $v0, $zero, 5
 	syscall 

	# storing divisor
 	add $t1, $zero, $v0
 	sw $t1, divisor

	addi $t2, $zero, 0
	
	while_1: slt $t3, $t0, $t1
		 bne $t3, $zero, show_result
		 sub $t0, $t0, $t1
		 addi $t2, $t2, 1 
		 j while_1

	
	show_result: 
	
	addi $v0, $zero, 4
 	la $a0, represent_quotient
 	syscall 

	addi $v0, $zero, 1
 	addi $a0, $t2, 0
 	syscall 
 	
 	addi $v0, $zero, 4
 	la $a0, new_line
 	syscall 
 	
	addi $v0, $zero, 4
 	la $a0, represent_remainder
 	syscall 

	addi $v0, $zero, 1
 	addi $a0, $t0, 0
 	syscall 


