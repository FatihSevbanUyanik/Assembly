.data
	array:    .space 12
	size:     .word  3
	sum:      .word  0
	avg:      .word  0	
	new_line: .asciiz "\n"
	
.text	
	main:
		move $t4, $zero
		li $t5, 10
		sw $t5, array($t4)
		
		li $t5, 20
		addi $t4, $t4, 4
		sw $t5, array($t4)
		
		li $t5, 60
		addi $t4, $t4, 4
		sw $t5, array($t4)
	
		addi $s0, $zero, 0		
		addi $s1, $zero, 0
		addi $s2, $zero, 0
		lw   $s3, size
		
		for_1: slt $t0, $s0, $s3
		       beq $t0, $zero, exit_1	
		       lw $t1, array($s1)      
		       add $s2, $s2, $t1
		       addi $s0, $s0, 1
		       addi $s1, $s1, 4  
		       j for_1
		       
		exit_1:
		
		sw $s2, sum
		lw $s3, size 
		div $t5, $s2, $s3
		sw $t5, avg
		
 		li $v0, 1
 		lw $a0, sum
 		syscall 
		
		li $v0, 4
 		la $a0, new_line
 		syscall 

		li $v0, 1
 		lw $a0, avg
 		syscall 

	# main
	li $v0, 10
 	syscall 
	
		