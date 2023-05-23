
.data

msg1: .asciiz "Enter Number of People: "
msg2: .asciiz "\n\nBanks Available: \nICICI Bank(1)\nState Bank of India(2)\nHDFC Bank(3)"
msg3: .asciiz "\nEnter Your Preferred Bank: "
msg4: .asciiz "\nEnter the Amount to Deposit: "
msg5: .asciiz "\nEnter Number of Years: "
msg6: .asciiz "\nSimple Interest gained is: "
msg7: .asciiz "\n\nBalance after "
msg8: .asciiz " years is: "

.text
main:
	# Number of people
	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	 
	while:
		
		blt $t0, 1, exit
		
		# Preffered Bank
		li $v0, 4
		la $a0, msg2
		syscall
		
		li $v0, 4
		la $a0, msg3
		syscall
		
		li $v0, 5
		syscall
		move $t1, $v0
		
		beq $t1, 1, ICICI
		beq $t1, 2, SBI
		beq $t1, 3, HDFC
	
	ICICI:
		# Set rate
		li $t2, 5
			
		jal Simple_Interest
		jal Print_Interest
		
		subi $t0, $t0, 1
		j while
		
	SBI:
		# Set rate
		li $t2, 9
		jal Simple_Interest
		jal Print_Interest
		
		subi $t0, $t0, 1
		j while
		
	HDFC:
		# Set rate
		li $t2, 3
		jal Simple_Interest
		jal Print_Interest
		
		subi $t0, $t0, 1
		j while
		
		
	Simple_Interest:
	
		# Amount
		li $v0, 4
		la $a0, msg4
		syscall
		
		li $v0, 5
		syscall
		move $t3, $v0
		
		# No of Years
		li $v0, 4
		la $a0, msg5
		syscall
		
		li $v0, 5
		syscall
		move $t4, $v0
		
		# SI = (A*Rate*Years) / 100
		li $t5, 100
		mul $t6, $t2, $t3
		mul $t6, $t6, $t4
		div $t6, $t6, $t5
		move $v1, $t6
		
		add $t7, $t6, $t3
		
		jr $ra
	
	Print_Interest:
		li $v0, 4
		la $a0, msg6
		syscall
		
		li $v0, 1
		move $a0, $v1
		syscall
		
		li $v0, 4
		la $a0, msg7
		syscall
		
		li $v0, 1
		move $a0, $t4
		syscall
		
		li $v0, 4
		la $a0, msg8
		syscall
		
		li $v0, 1
		move $a0, $t7
		syscall
		
		jr $ra

	exit:
		li $v0, 10
		syscall
