# -*- coding: utf-8 -*-
import socket, select , time

SOCKET_LIST = []    # lista de sockets abertos
RECV_BUFFER = 4096  # valor recomendado na doc. do python
PORT = 5000
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server_socket.connect(("", PORT))

def menu_inicial():
    print('Bem vindo')
    print('Menu Inicial')
    print("""Escolha uma das seguintes opções:
    1 - Criar novo utilizador
    2 - Login
    3 - Sair """)
    input_inicial = int(input('Escolha uma das opções acima'))

    if 1 < input_inicial > 3:
        print('Opção não valida')

    if input_inicial == 1:
        nome = input('Escolha o seu nome de utilizador: ')
        senha = input('Escolha uma password: ')
        mensagem = 'REGISTER' + ' ' + nome + ' ' + senha
        aux = mensagem.encode('Utf-8')
        server_socket.sendall(aux)
        data = server_socket.recv(RECV_BUFFER)
        mensage_received_server = str(data.decode())
        if mensage_received_server == 'OK_REGISTER':
            menu_utilizador()
        else:
            print('Ocurreu um erro durante o seu registo')
            menu_inicial()


    if input_inicial == 2:
        nome = input('Escolha o seu nome de utilizador: ')
        senha = input('Escolha uma password: ')
        mensagem = 'LOGIN' + ' ' + nome + ' ' + senha
        aux = mensagem.encode('Utf-8')
        server_socket.sendall(aux)
        data = server_socket.recv(RECV_BUFFER)
        mensage_received_server = str(data.decode())
        if mensage_received_server == 'OK':
            menu_utilizador()
        else:
            print('Ocurreu um erro durante o seu LOGIN')
            menu_inicial()

    if input_inicial == 3:
        print('Saiu')
        mensagem = 'GOODBYE'
        aux = mensagem.encode('utf-8')
        server_socket.sendall(aux)
                      
def menu_utilizador():
    dia = time.strftime("%x")
    hora = time.strftime("%X")
    data=(dia +' '+ hora)
                      
    print('Menu Utilizador')
    print("""Escolha uma das seguintes opções:
    1 - Ver mensagens publicas
    2 - Ver mensagens privadas
    3 - Enviar mensagem publica
    4 - Enviar mensagem privada
    5 - Sair """)

    input_utilizador = int(input('Escolha uma das opções acima'))
    if 1 < input_utilizador > 5:
        print('Opção não valida')

    if input_utilizador == 1:
        mensagem = 'PUBLICMSGS'
        aux = mensagem.enconde('utf-8')
        server_socket.sendall(aux)

    if input_utilizador == 2:
        mensagem = 'PRIVMSGS'
        aux = mensagem.enconde('utf-8')
        server_socket.sendall(aux)

    if input_utilizador == 3:
        mensagemP = input('Digite a mensagem a enviar')
        mensagem = 'SENDMSG' + ' ' + data + ' ' + mensagemP
        aux = mensagem.enconde('utf-8')
        server_socket.sendall(aux)

    if input_utilizador == 4:
        utilizadorC = input('Digite o nome do utilizador que deseja contactar: ')
        mensagemP = input('Digite a mensagem a enviar: ')
        mensagem = 'SENDPRIVMSG' + ' ' + data + ' ' + utilizadorC + ' ' + mensagemP
        aux = mensagem.enconde('utf-8')
        server_socket.sendall(aux)

    if input_utilizador == 5:
        server_socket.close()
        
menu_inicial()

