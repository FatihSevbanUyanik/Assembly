.data
	new_line:       .asciiz "\n"
	request_number: .asciiz "Please enter a number: "
	display_number: .asciiz "Chosen number is: "
	request_name:   .asciiz "Please type your name: "
	display_name:   .asciiz "Your name is: "
	name_length:    .word   30
	name:           .space  30
	display_young:  .asciiz "You are young." 
	display_old:    .asciiz "You are old." 	
	
.text
	main:
		# requesting number
 		li $v0, 4
 		la $a0, request_number
 		syscall 
		
		# getting user input
 		li $v0, 5
 		syscall 
		
		# string number in t0
		move $t0, $v0
		
		# displaying number
 		li $v0, 4
 		la $a0, display_number
 		syscall 
 		
 		# printing an integer
 		li $v0, 1
 		move $a0, $t0
 		syscall 
 		
		jal goto_new_line
		jal goto_new_line		
		
		# requesting name
 		li $v0, 4
 		la $a0, request_name
 		syscall 
		
		# getting user input text
 		li $v0, 8
 		la $a0, name
 		la $a1, name_length
 		syscall 
 		
 		# displaying name input 
 		li $v0, 4
 		la $a0, display_name
 		syscall 
 		
 		li $v0, 4
 		la $a0, name
 		syscall 
 		
 		# determining young or old
 		addi $t1, $zero, 25
 		slt $t3, $t0, $t1
 		
 		beq $t3, $zero, target1
 		    li $v0, 4
 		    la $a0, display_young
 		    syscall
 		j exit1
 		target1:
 		    li $v0, 4
 		    la $a0, display_old
 		    syscall
 		exit1:
		
	# main
	li $v0, 10
 	syscall 
 			
  	goto_new_line:
 		li $v0, 4
		la $a0, new_line
 		syscall 
 		jr $ra
 	# goto_new_line

 		