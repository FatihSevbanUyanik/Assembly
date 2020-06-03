.data
a: .word 0
b: .word 0
c: .word 0
d: .word 0
e: .word 0
request_a: .asciiz "Please enter a: "
request_b: .asciiz "Please enter b: "
request_c: .asciiz "Please enter c: "
request_d: .asciiz "Please enter d: "
request_e: .asciiz "Please enter e: "
represent_result: .asciiz "Result: "
.text
	main:
	 	#######################################################
		# requesting a
 		addi $v0, $zero, 4
 		la $a0, request_a
	 	syscall 
	 	
	 	# getting a
 		addi $v0, $zero, 5
 		syscall 
 		
 		# storing a
 		addi $s0, $v0, 0
 		sw $s0, a
 		#######################################################
 		# requesting b
 		addi $v0, $zero, 4
 		la $a0, request_b
	 	syscall 
	 	
	 	# getting b
 		addi $v0, $zero, 5
 		syscall 
 		
 		# storing b
 		addi $s1, $v0, 0
 		sw $s1, b
  		#######################################################
 		# requesting c
 		addi $v0, $zero, 4
 		la $a0, request_c
	 	syscall 
	 	
	 	# getting c
 		addi $v0, $zero, 5
 		syscall 
 		
 		# storing c
 		addi $s2, $v0, 0
 		sw $s2, c
  		#######################################################
 		# requesting d
 		addi $v0, $zero, 4
 		la $a0, request_d
	 	syscall 
	 	
	 	# getting d
 		addi $v0, $zero, 5
 		syscall 
 		
 		# storing d
 		addi $s3, $v0, 0
 		sw $s3, d
  		#######################################################
 		# requesting e
 		addi $v0, $zero, 4
 		la $a0, request_e
	 	syscall 
	 	
	 	# getting e
 		addi $v0, $zero, 5
 		syscall 
 		
 		# storing e
 		addi $s4, $v0, 0
 		sw $s4, e
  		#######################################################
 		
 		
 		mul $t0, $s0, 2 # 2A
 		sub $t1, $s1, $s2 # B-C
 		mul $t2, $t0, $t1 # 2A*(B-C)
 		add $t3, $t2, $s3 # 2A*(B-C) + D
 				
 		# modular
 		div $t4, $t3, $s4
		mul $t1, $t4, $s4
		sub $t3, $t3, $t1 
 		
		# result
 		addi $v0, $zero, 4
 		la $a0, represent_result
	 	syscall 
	 	
	 	addi $v0, $zero, 1
 	       	addi $a0, $t3, 0
 	       	syscall

	# main
	li $v0, 10
 	syscall 
