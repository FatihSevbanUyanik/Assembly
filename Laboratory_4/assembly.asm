.data 
.text
	main:
		addi $s0, $zero, 5 	# testing I Type add immediate. 
		addi $s1, $zero, 4
		sub $s2, $s0, $s1 	# testing R Type sub.
		
		addi $sp, $sp, -4
		sw $s2, 0($sp)		# testing I Type store word.
		lw $s2, 0($sp)		# testing I Type load word.
		addi $sp, $sp, 4

		addi $a0, $zero, 1
		addi $a1, $zero, 0
		or $a2, $a0, $a1 	# testing R Type or
		nor $a2, $a0, $a1 	# testing R Type nor
		and $a2, $a0, $a1	# testing R Type and
		ori $a3, $a1, 1		# testing I Type or immediate
		andi $a3, $a1, 1	# testing I type and immediate

		j jump_1 		# testing J type jump
		jump_1:

		slt $s4, $s0, $s1 	# testing R Type set less than
		beq $s4, $zero, jump_2	# testing I type branch equal
		jump_2:

		lui $t1, 0x89FA		 # testing required I Type lui
		jalm $t5, 40($s3)	 # testing required I Type jalm

