
.data
message: .asciiz "Entrer un nombre naturel: "
resultat: .asciiz "Fib(N)"
egal: .asciiz " = "
sautdeligne: .asciiz "\n"

.text
main:

la $a0,message # Afficher "Entrer un nombre naturel: " 
li $v0,4
syscall

li $v0,5    #Lire n
syscall

move $t2,$v0    # n to $t2

# Appel de la fonction
move $a0,$t2
move $v0,$t2
jal fib     #call fib (n)
move $t3,$v0    #result is in $t3

la $a0,resultat   #Afficher Fib(N)
li $v0,4
syscall

move $a0,$t2    #Afficher n
li $v0,1
syscall

la $a0,egal  #Afficher =
li $v0,4
syscall

move $a0,$t3    #Afficher la réponse
li $v0,1
syscall

la $a0,sautdeligne #Afficher '\n'
li $v0,4
syscall


li $v0,10
syscall

fib:
# Calcul et return 
beqz $a0,zero   #si n=0 return 0
beq $a0,1,un   #si n=1 return 1

#appel fib(n-1)
sub $sp,$sp,4   #empiller l'adresse de retour 
sw $ra,0($sp)

sub $a0,$a0,1   #n-1
jal fib     #fib(n-1)
add $a0,$a0,1

lw $ra,0($sp)   #depiler l'adresse de retour 
add $sp,$sp,4


sub $sp,$sp,4   #Push return value to stack
sw $v0,0($sp)
#Calling fib(n-2)
sub $sp,$sp,4   #empiler l'adresse de retour 
sw $ra,0($sp)

sub $a0,$a0,2   #n-2
jal fib     #fib(n-2)
add $a0,$a0,2

lw $ra,0($sp)   #depiler l'adresse de retour 
add $sp,$sp,4
#---------------
lw $s7,0($sp)   #depiler la valeur de retour 
add $sp,$sp,4

add $v0,$v0,$s7 # f(n - 2)+fib(n-1)
jr $ra # retour a la fonction appelante

zero:
li $v0,0
jr $ra
un:
li $v0,1
jr $ra




