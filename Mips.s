.data
	msg1: .asciiz "Donner N\n"
	msg2: .asciiz "Eelement "
	msg3: .asciiz "Tableau Donne :\n"
	msg4: .asciiz "Tableau Trie :\n"
	msg5: .asciiz ":\n"
	tab: .space 200
	N: .word 0
	J: .word 0
	I: .word 0
	PMAX: .word 0
	AIDE: .word 0
	Const4: .word 4
.text
main:
	lw $16,N($0)		#
	la $4,msg1			# printf("donner N\n");
	ori $2,$0,4			#
	syscall				#
	
	ori $2,$0,5			#
	syscall				# scanf("%d",&N);
	add $16,$0,$2		#
	sw $16,N($0)		#
	
	lw $17,J($0)		#
	addi $17,$0,0		# J=0
	lw $21,Const4($0)	# const 4

while:
	mul $18,$17,$21		# j*4
	beq $17,$16,end1	# brench if J=N
	la $4,msg2			#
	ori $2,$0,4			#
	syscall				#
						# printf("Elément %d : ", J);
	add $4,$17,$0		#
	ori $2,$0,1			#
	syscall	

	la $4,msg5			#
	ori $2,$0,4			#
	syscall				#

	ori $2,$0,5			#
	syscall				#scanf("%d", &A[J]);

	add $19,$0,$2		#
	sw $19,tab($18)		#
	addi $17,$17,1 		# j++

	j while
end1:
	
	la $4,msg3    		#
	ori $2,$0,4			# printf("Tableau donné :\n");
	syscall				#

	addi $17,$0,0 		# j=0

Boucle:
	mul $18,$17,$21		# j*4
	beq $17,$16,fin
	lw $4,tab($18)
	ori $2,$0,1			#printf("%d ", A[J]);
	syscall
	addi $17,$17,1		#j++
	j Boucle
fin:

	addi $8,$16,-1 		# N-1
	lw $9,I($0) 
	addi $9,$0,0
	lw $10,PMAX($0)
	lw $11,AIDE($0)

for1:
	
	beq $9,$8,endfor1
	addi $10,$9,0 		#PMAX=I
	addi $17,$9,0 		#I=J+1

for2:
	beq $17,$16,endfor2
	mul $12,$9,$21 		#i*4
	mul $13,$10,$21		#PMAX*4
	mul $14,$17,$21		#j*4

	lw $24,tab($14)		#A[j]
	lw $25,tab($13)		#A[PMAX]

IF: blt $25,$24,endif
	beq $25,$24,endif
	addi $10,$17,0		#PMAX=J
	addi $13,$14,0		#PMAX*4=J*4
	lw $25,tab($13),	#A[PMAX]
endif:
	lw $15,tab($12)		#A[i]
	addi $11,$15,0		#AIDE=A[i]
	addi $15,$25,0		#A[i]=A[PMAX]
	addi $25,$11,0		#A[PMAX]=A[i]

	sw $25,tab($13)
	sw $15,tab($12)

	addi $17,$17,1 		#j++

	j for2
endfor2:
	addi $9,$9,1 		#i++

	j for1
endfor1:

	la $4,msg4    		#
	ori $2,$0,4			# printf("Tableau trie :\n");
	syscall				#

	addi $17,$0,0 		# j=0
Boucle2:
	mul $18,$17,$21		# j*4
	beq $17,$16,fin
	lw $4,tab($18)
	ori $2,$0,1			#printf("%d ", A[J]);
	syscall
	addi $17,$17,1		#j++
	j Boucle
fin2: