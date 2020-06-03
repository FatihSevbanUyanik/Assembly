.text

	la $a0, msgHello
	li $v0, 4
	syscall # print message hello
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	

main:
	jal printMenu
	
	la $a0, msgAskOption
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall

	jal chooseOption
	
	j main

#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	

printMenu:
	la $a0, msgAskSize
	li $v0, 4
	syscall # Enter the size of Matrix and write values one by one
	
	la $a0, msgAskSize2
	li $v0, 4
	syscall
	
	la $a0, msgReadFromMatrix
	li $v0, 4
	syscall
	
	la $a0, msgDisplayAllMatrix
	li $v0, 4
	syscall
	
	la $a0, msgObtainTraceAndDisplay
	li $v0, 4
	syscall
	
	la $a0, msgdiagonalSum
	li $v0, 4
	syscall
	
	la $a0, msgRowMajorSum
	li $v0, 4
	syscall
	
	la $a0, msgColumnMajorSum
	li $v0, 4
	syscall
	
	la $a0, msgExit
	li $v0, 4
	syscall
	
	jr $ra
	
#--------------------------------------------------------------#
#--------------------------------------------------------------#	
#--------------------------------------------------------------#
#--------------------------------------------------------------#	
		
chooseOption:
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	beq $v0, 1, choose1
	beq $v0, 2, choose2
	beq $v0, 3, choose3
	beq $v0, 4, choose4
	beq $v0, 5, choose5
	beq $v0, 6, choose6
	beq $v0, 7, choose7
	beq $v0, 8, choose8
	beq $v0, 9, exit
choose1:
	jal createMatrixByUser
	j goMain
choose2:
	jal createMatrixByProgram
	j goMain
choose3:
	jal displayElement
	j goMain
choose4:
	jal displayMatrix
	j goMain
choose5:
	jal obtainTraceofMatrix
	j goMain
choose6:
	jal sumdiagonal
	j goMain
choose7:
	jal sumRowMajor
	j goMain
choose8:
	jal sumColumnMajor
	j goMain
	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	

goMain:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#

#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
createMatrixByUser:
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, msgAskSize
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $a0, $v0
	
	jal createMatrix
	
	move $a0, $v0 ## array beginning
	move $a1, $v1 ## array size

	jal writeValuesByUser
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	

createMatrixByProgram:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, msgAskSize
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $a0, $v0
	
	jal createMatrix
	
	move $a0, $v0 ## array beginning
	move $a1, $v1 ## array size
	
	jal writeConsecutiveValues
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra

#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	

displayElement:
	addi $sp, $sp, -12
	sw $s1, 8($sp)
	sw $s0, 4($sp)
	sw $ra, 0($sp)
	
	#ask user i
	la $a0, msgEnterI
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	 
	#ask user j
	la $a0, msgEnterJ
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	#calculate index of matrix
	addi $t0, $t0, -1
	mul $t0, $t0, $s0
	mul $t0, $t0, 4
	addi $t1, $t1, -1
	mul $t1, $t1, 4
	add $t0, $t1, $t0 # $t0 is the index of element
	
	# add index to beginning of the array
	add $t1, $s1, $t0 # t1 is the address of element
	
	# take element from mem
	lw $t2, 0($t1)
	
	## display the element
	add $a0, $zero, $t2
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall # endl
	
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12
		
	jr $ra
	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	

displayMatrix:
	
	addi $t0, $zero, 1 #i 
	addi $t1, $zero, 1 #j
	addi $t6, $s0, 1 # N + 1 for loops
rowLoop: beq $t0, $t6, endRow
columnLoop: beq $t1, $t6, endColumn
	#calculate index of matrix
	addi $t3, $t0, -1
	mul $t3, $t3, $s0
	mul $t3, $t3, 4
	addi $t4, $t1, -1
	mul $t4, $t4, 4
	add $t3, $t4, $t3 # $t0 is the index of element
	
	# add index to beginning of the array
	add $t4, $s1, $t3 # t4 is the address of element
	
	# take element from mem
	lw $t5, 0($t4)
	
	## display the element
	add $a0, $zero, $t5
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall # space
	
	addi $t1, $t1, 1
	
	j columnLoop
endColumn:
	addi $t1, $zero, 1
	addi $t0, $t0, 1
	
	la $a0, endl
	li $v0, 4
	syscall # endl
	
	j rowLoop
endRow:
	jr $ra
	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	

obtainTraceofMatrix:
	addi $t0, $zero, 1 #i 
	addi $t1, $s0, 1 # N + 1
	addi $t4, $zero, 0
traceLoop: beq  $t0, $t1, endTrace
	#calculate index of matrix
	addi $t2, $t0, -1
	mul $t2, $t2, 4
	mul $t2, $t2, $s0
	addi $t3, $t0, -1
	mul $t3, $t3, 4
	add $t2, $t2, $t3 # index of matrix is $t2
	
	#find the address
	add $t3, $s1, $t2 #address of first item
	
	#get the item
	lw $t2, 0($t3)
	
	add $t4, $t4, $t2

	
	addi $t0, $t0, 1
	
	j traceLoop
endTrace:	

	## display the element
	add $a0, $zero, $t4
	li $v0, 1
	syscall  


	la $a0, endl
	li $v0, 4
	syscall # endl
	
	jr $ra
	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	

sumdiagonal:

	addi $t0, $zero, 1 #i 
	add $t1, $zero, $s0 #j
	addi $t4, $zero, 0
reverseTraceLoop: beq  $t1, 0, endReverseTrace
	
	#calculate index of matrix
	addi $t2, $t0, -1
	mul $t2, $t2, 4
	mul $t2, $t2, $s0
	addi $t3, $t1, -1
	mul $t3, $t3, 4
	add $t2, $t2, $t3 # index of matrix is $t2
	
	#find the address
	add $t3, $s1, $t2 #address of first item
	
	#get the item
	lw $t2, 0($t3)
	
	add $t4, $t4, $t2
	

	
	addi $t0, $t0, 1
	addi $t1, $t1, -1
	
	j reverseTraceLoop
	 

endReverseTrace:	

	## display the element
	add $a0, $zero, $t4
	li $v0, 1
	syscall  

	la $a0, endl
	li $v0, 4
	syscall # endl
	
	jr $ra
	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	

sumRowMajor:

	addi $t0, $zero, 1 #i 
	addi $t1, $zero, 1 #j
	addi $t6, $s0, 1 # N + 1 for loops
	addi $t7, $zero, 0
rowLoop2: beq $t0, $t6, endRow2
columnLoop2: beq $t1, $t6, endColumn2

	#calculate index of matrix
	addi $t3, $t0, -1
	mul $t3, $t3, $s0
	mul $t3, $t3, 4
	addi $t4, $t1, -1
	mul $t4, $t4, 4
	add $t3, $t4, $t3 # $t0 is the index of element
	
	# add index to beginning of the array
	add $t4, $s1, $t3 # t4 is the address of element
	
	# take element from mem
	lw $t5, 0($t4)
	
	add $t7, $t7, $t5
	
	addi $t1, $t1, 1
	
	j columnLoop2
endColumn2:
	## display the element
	add $a0, $zero, $t7
	li $v0, 1
	syscall  
	
	la $a0, space
	li $v0, 4
	syscall # space
	
	addi $t1, $zero, 1
	addi $t0, $t0, 1
	addi $t7, $zero, 0

	j rowLoop2
	
endRow2:

	la $a0, endl
	li $v0, 4
	syscall # endl
	
	jr $ra
	
	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	

sumColumnMajor:

	addi $t0, $zero, 1 #i 
	addi $t1, $zero, 1 #j
	addi $t6, $s0, 1 # N + 1 for loops
	addi $t7, $zero, 0
rowLoop3: beq $t0, $t6, endRow3
columnLoop3: beq $t1, $t6, endColumn3

	#calculate index of matrix
	addi $t3, $t1, -1
	mul $t3, $t3, $s0
	mul $t3, $t3, 4
	addi $t4, $t0, -1
	mul $t4, $t4, 4
	add $t3, $t4, $t3 # $t0 is the index of element
	
	# add index to beginning of the array
	add $t4, $s1, $t3 # t4 is the address of element
	
	# take element from mem
	lw $t5, 0($t4)
	
	add $t7, $t7, $t5
	
	addi $t1, $t1, 1
	
	j columnLoop3
endColumn3:
	## display the element
	add $a0, $zero, $t7
	li $v0, 1
	syscall  
	
	la $a0, space
	li $v0, 4
	syscall # space
	
	addi $t1, $zero, 1
	addi $t0, $t0, 1
	addi $t7, $zero, 0

	j rowLoop3
	
endRow3:

	la $a0, endl
	li $v0, 4
	syscall # endl
	
	jr $ra


#--------------------------------------------------------------#	
#--------------------------------------------------------------#
	# s0 keeps N
	# s1 keeps array's beginning		
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	

createMatrix:
	# $t0 N
	# $t1 NxN
	# $v0 beginnig of array return
	
	move $t0, $a0
	move $s0, $a0
	mul $t1, $t0, $t0
	
	mul $t3, $t1, 4
	
	move $a0, $t3
	li $v0, 9
	syscall
	
	move $s1, $v0
	move $v1, $t0
	
	jr $ra

#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	

writeValuesByUser:
	
	move $t0, $v0 ## array beginnig
	move $t1, $v1 ## N
	move $t2, $t1 ## N
	
	addi $t3, $zero, 1 # i
	addi $t4, $zero, 1 # j
	
loop1: beq $t1, 0, done1
loop2: beq $t2, 0, done2

#-------------------------------------------------------------------------#
		
	   # to print index of matrix etc. (1,1) (2,1)...
		
	   la $a0, enterValue
	   li $v0, 4
	   syscall

	   la $a0, open
	   li $v0, 4
	   syscall
	   
	   move $a0, $t3
	   li $v0, 1
	   syscall
	   
	   la $a0, comma
	   li $v0, 4
	   syscall
	   					
	   la $a0, space
	   li $v0, 4
	   syscall
	   
	   move $a0, $t4
	   li $v0, 1
	   syscall
	   
	   la $a0, close
	   li $v0, 4
	   syscall
	   
	   la $a0, endl
	   li $v0, 4
	   syscall
	   
#-------------------------------------------------------------------------#
	   
	   li $v0, 5
	   syscall #ask user to value
	   
	   sw $v0, 0($t0) #put this value into the matrix
	   
	   addi $t0, $t0, 4
	   addi $t2, $t2, -1
	   addi $t4, $t4, 1 #update current index
	   j loop2
done2:
	addi $t1, $t1, -1
	addi $t4, $zero, 1
	addi $t3, $t3, 1
	move $t2, $v1 #update current index
	j loop1
done1:
	jr $ra # go parent method

#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#

writeConsecutiveValues:
	move $t0, $v0 ## array beginnig
	move $t1, $v1 ## N
	move $t2, $t1 ## N
	
	addi $t3, $zero, 1
	
loop3: beq $t1, 0, done3
loop4: beq $t2, 0, done4
	
		sw $t3, 0($t0)
		
		addi $t3, $t3, 1
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		
		j loop4
done4:
	move $t2, $s0
	addi $t1, $t1, -1
	j loop3
done3:
	jr $ra

exit:
	li $v0, 10
	syscall

#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	
#--------------------------------------------------------------#	



.data
msgEnterJ: .asciiz "Enter the j index\n"
msgEnterI: .asciiz "Enter the i index\n"
enterValue: .asciiz "Enter the value of "
open: .asciiz "("
close: .asciiz ")"
comma: .asciiz ","
endl: .asciiz "\n"
space: .asciiz " "
msgExit: .asciiz "9 - Exit\n"
msgAskOption: .asciiz "Choose Option\n"
msgHello: .asciiz "Hello User\n"
msgAskSize: .asciiz "1- Enter the size of Matrix and write values one by one\n"
msgAskSize2: .asciiz "2- Enter the size of Matrix and values are created by program\n"
msgReadFromMatrix: .asciiz "3 - Display the spesific element\n"
msgDisplayAllMatrix: .asciiz "4 - Display the all matrix\n"
msgObtainTraceAndDisplay: .asciiz "5 - Obtain trace of the matrix and display\n"
msgdiagonalSum: .asciiz "6 - Obtain trace like summation using the other diagonal of the matrix and display\n"
msgRowMajorSum: .asciiz "7 - Obtain sum of matrix elements by row-major (row by row) summation\n"
msgColumnMajorSum: .asciiz "8 - Obtain sum of matrix elements by column-major (column by column) summation.\n"
#7.	Obtain sum of matrix elements by row-major (row by row) summation,
#8.	Obtain sum of matrix elements by column-major (column by column) summation.

