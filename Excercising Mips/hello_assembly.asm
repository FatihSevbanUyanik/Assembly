 .data
 	message: .asciiz  "Hello World \n"
 	character: .byte  'm'
 	age: .word 23
 .text
 	# printing a string
 	li $v0, 4
 	la $a0, message
 	syscall 
 	
 	# printing a character
 	li $v0, 4
 	la $a0, character
 	syscall 
 	
 	# printing an integer
 	li $v0, 1
 	lw $a0, age
 	syscall 