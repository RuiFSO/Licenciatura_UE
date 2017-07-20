.data
pedirNome: .asciiz "Introduza o nome do ficheiro \n"
nome: .asciiz "/home/jp/Documentos/TrabalhoASC/musica.txt"

texto: .space 1024 # espaco reservado no buffer para a introducao do nome do ficheiro
musica: .space 1024 # espaco reservado no buffer para a introducao da musica

.text

#################################################################
# Main - Funcao principal que não tem argumentos nem retorno
#
#################################################################
Main:
	jal input
	nop
	
	jal openFile
	nop

	jal instrument
	nop
	
	jal time
	nop
	
#################################################################
# input - pede ao utilizador o nome do ficheiro
#
# Argumentos:
#  $a0 - mensagem apresentada no ecrã
#  $v0 - sycall
#  
#
# Retorna:
#  retorna a mensagem para ecrã
#  da ao utilizador espaco para escrever
#  
#
#################################################################
input:
	# Mostra mensagem a pedir o nome do ficheiro
	la $a0, pedirNome
	li $v0, 4 	# imprime uma string
	syscall
	
	# Pede o nome do ficheiro
	la $a0, texto	# endereço do texto
	la $a1, texto	# numero maximo de caracteres
	li $v0, 8 	# pedir o input - ler string
	syscall
	
	jr $ra
	nop


#################################################################
# openFile - abre o ficheiro
#
# Argumentos:
#  $a0 - nome do ficheiro
#  
#
# Retorna:
#  nao tem retorno
#
#################################################################
openFile:
	# Abrir ficheiro
	la $a0, nome	# nome do ficheiro
	li $a1, 0	# apenas modo leitura
	li $a2, 0	
	li $v0, 13	# abrir ficheiro
	syscall


#################################################################
# read - le o ficheiro
#
# Argumentos:
#	$s1 - espaço dedicado para armazenar o ficheiro  
#
# Retorna:
# 
#
#################################################################
read:
	move $a0, $v0	# move o ficheiro para $a0
	la $a1, nome	# endereço que contemo caminho para o ficheiro
	la $a2, nome	# numero de caracters maximos que a função le
	li $v0, 14
	syscall
	
	la $s1, nome
			

#################################################################
# instrument - encontra e converte o valor do instrumento de hexadecimal para binário
#
# Argumentos:
#  	$t1 - valor do 1º bit da pilha
#	$t2 - guarda o valor temporário do instrumento
#	$t7 - contador
#	$t5 - registo auxilar para as contas
# Retorna:
#  	$s0 - guarda o valor final do instrumento
#
#################################################################	
instrument:
	lb $t1, 0($s1)		# le o 1º bit do ficheiro
	bne $t1, 0x20, counterInst	#caso $t1 seja diferente do caracter espaço, salta para a função counterInst
	addi $s1, $s1, 1
	beq $t1, 0x20, nextFunct		#quando encontra o espaço salta para a função que guarda o $t2 em $s0
	nop
	
counterInst:	#converte o valor de hexadecimal para decimal
	add $t7, $t7, $zero	# coloca o contador ($t7) a zero
	beq $t7, $zero, zero	# verifica se o contador é zero
	nop
	bne $t7, $zero, difZero	#verifica se o contador é diferente de zero
	nop

zero:					#incrementa um valor no contador
	move, $t2, $t1		# guarda o $t1 em "t2
	addi $t2, $t2, -48	# hexa para deci
	j instrument
	addi $t7, $t7, 1

difZero:
	addi $t1, $t1, -48	# converte de hexadecimal para decimal
	sll $t5, $t2, 3		# multiplica $t2 por 8
	add $t5, $t2, $t5	# soma $t2 + 1 ($t5 é um registo auxilar)
	add $t2, $t2, $t5	# $t2+1 = $t2 * 10
	add $t2, $t2, $t1	# soma $t2 com $t1
	xor $t5, $t5, $t5	# coloca $t5 novamente a zero
	j instrument
	addi $t7, $t7, 1	# incrementa 1 em $t7
	
nextFunct:
	move $s0, $t2
	j time
	nop
	
	
#################################################################
# time - encontra e converte o tempo de hexadecimal para decimal
#
# Argumentos:
#   	$t1 - valor do 1º bit da pilha
#	$t2 - guarda o valor temporário do tempo
#	$t7 - contador
#	$t5 - registo auxilar para as contas
#	
# Retorna:
#  	$s2 - guarda o valor final do tempo
#
#################################################################	
time:				# coloca os registos a 0
	xor $t0, $t0, $t0
	xor $t2, $t2, $t2
	xor $t5, $t5, $t5
	xor $t7, $t7, $t7

time1:
	lb $t1, 0($s1)		# le o 1º bit do ficheiro
	bne $t1, 0xa, counterTime	#verifica o primeiro bit a seguir ao espaço, e caso seja um valor diferente de "|n" salta para a função counterTime
	nop
	beq $t1, 0xa, nextFunct1
	addi $s1, $s1, 1
	
counterTime:	#converte o valor de hexadecimal para decimal
	addi $s1, $s1, 1
	add $t7, $t7, $zero	# coloca o contador (t7) a zero
	beq $t7, $zero, zero1	# verifica se o contador é zero
	nop
	bne $t7, $zero, difZero1	# verifica se o contador é diferente de zero
	nop

zero1:
	move, $t2, $t1	# guarda o t1 em t2
	addi $t2, $t2, -48	# converte de hexadecimal para decimal
	j time1
	addi $t7, $t7, 1

difZero1:
	addi $t1, $t1, -48	#hexa para deci
	sll $t5, $t2, 3	#multiplica $t2 por 8
	add $t5, $t2, $t5	#soma $t2 + 1 ($t5 é um registo auxilar)
	add $t2, $t2, $t5	#$t2+1 = $t2 * 10
	add $t2, $t2, $t1	# soma $t2 com $t1
	xor $t5, $t5, $t5	#coloca $t5 novamente a zero
	j time1
	addi $t7, $t7, 1	#incrementa 1 em t7
	
nextFunct1:	#guarda o valor do tempo em $s2
	move $s2, $t2
	j play
	nop


#################################################################
# music - converte as notas para numeros decimais
#
# Argumentos:
# $t1 - valor do primeiro bit da pilha
# $t4 - valor temporário da nota
#
# Retorna:
#  
#
#################################################################
music:
	addi $s1, $s1, 1		# coloca o $s1 no byte da primeira nota
	lb $t1, 0($s1)
	
	bne $t1, 0x2d, convert		# salta se for != traco
	nop

verificaNext:	#verifica o caracter a seguir ao 1º bit
	addi $s1, $s1, 1
	lb $t1, 0($s1)
	beq $t4, 0x2d, incremTime	# salta se for = traco
	nop
	beq $t4, 0x23, convertSust	# salta se for = #
	nop
	beq $t4, 0xa, exit
	nop
	j play
	nop
							

incremTime:	# duplica o tempo da nota
	sll $s0, $s0, 1			
	j verificaNext
	nop
									
convert:		#converte o valor de $t4 de hexadecimal para decimal
	move $t4, $t1
	
	beq $t4, 0x41, a
	nop
	beq $t4, 0x42, b
	nop
	beq $t4, 0x43, c
	nop
	beq $t4, 0x44, d
	nop
	beq $t4, 0x45, e
	nop
	beq $t4, 0x46, f
	nop
	beq $t4, 0x47, g
	nop
a:
	addi $t4, $t4, 28
	j verificaNext
	nop
b:
	addi $t4, $t4, 29
	j verificaNext
	nop
c:	
	addi $t4, $t4, 17
	j verificaNext
	nop
d:
	addi $t4, $t4, 12
	j verificaNext
	nop
e:
	addi $t4, $t4, 19
	j verificaNext
	nop		
f:	
	addi $t4, $t4, 19
	j verificaNext
	nop
g:
	addi $t4, $t4, 10
	j verificaNext
	nop
	
convertSust:	#adiciona, caso exista, o sustenido
	beq $t4, 0x41, aSust
	nop
	beq $t4, 0x42, bSust
	nop
	beq $t4, 0x43, cSust
	nop
	beq $t4, 0x44, dSust
	nop
	beq $t4, 0x45, eSust
	nop
	beq $t4, 0x46, fSust
	nop
	beq $t4, 0x47, gSust
	nop
aSust:
	addi $t4, $t4, 29
	j verificaNext
	nop
bSust:
	addi $t4, $t4, 30
	j verificaNext
	nop
cSust:	
	addi $t4, $t4, 18
	j verificaNext
	nop
dSust:
	addi $t4, $t4, 13
	j verificaNext
	nop
eSust:
	addi $t4, $t4, 20
	j verificaNext
	nop		
fSust:	
	addi $t4, $t4, 20
	j verificaNext
	nop
gSust:
	addi $t4, $t4, 11
	j verificaNext
	nop
	
														
#################################################################
# play - toca a musica existente no ficheiro
#
# Argumentos:
#  	$a3 - volume
#	$a2 - tempo em milisegundos
#	$a1 - instrumento
#	$a0 - nota atual
# Retorna:
#  	#v0 - som das notas musicais
#
#################################################################	
play:
	
	
	li $a3, 100	# volume
	move $a2, $s0	# tempo em ms
	move $a1, $s2	# instrumento
	move $a0, $t4	# nota
	li $v0,33
	syscall
	
	beq $t4, 0xa, exit	# salta se $t4
	nop	 
	
	j music
	nop
################################################################
#close -  funçao 
#
# Argumentos:
#   $a0 - ficheiro
#
# Retorna:
#   $v0 - syscall para fechar o ficheiro
#
#################################################################
close:
	la $a0, nome
	li $v0, 13
	syscall

#################################################################
# exit -  funçao  que serve para terminar o programa e não tem argumentos nem retorno
#  
#
#################################################################
exit:

	add $zero, $zero, $zero