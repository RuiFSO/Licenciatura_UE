# -*- coding: utf-8 -*-
import socket, select, datetime
login_dict = {}
file_send = 0

SOCKET_LIST = []
RECV_BUFFER = 4096
PORT = 5000

def process_cmd (data,sock):

	mensage_received_cliente = str(data.decode())
    comando, informacao = mensage_received_cliente.split(' ', 1)
 
    if comando == 'REGISTER':

        utilizador, senha = informacao.split(' ',1)
        ficheiro = open("utilizadores.txt")
        if informacao in ficheiro:
                print('ERR_ALREADY_EXISTS' + ' ' + utilizador)
                m = 'ERR_ALREADY_EXISTS' + utilizador
                sock.sendall(m.enconde('utf-8'))
                ficheiro.close()
        elif informacao not in ficheiro:
                ficheiro.write('\n'informacao + '\n')
                print('OK_REGISTERED' + utilizador)
                m = 'OK_REGISTERED' + utilizador
                sock.sendall(m.enconde('utf-8'))
                ficheiro.close()
        else:
                print('ERR_INVALID_DATA')
                m = 'ERR_INVALID_DATA'
                sock.sendall(m.enconde('utf-8'))
                ficheiro.close()

 	elif comando == 'LOGIN':

 		utilizador, senha = informacao.split(' ',1)
 		ficheiro = open("utilizadores.txt")
 		if informacao in ficheiro.read():
 			print('OK_LOGIN' + utilizador)
 			m =('OK_LOGIN' + utilizador)
 			sock.sendall(m.enconde('utf-8'))
            ficheiro.close()
      	else:
      		print(' ERR_LOGIN' + utilizador)
      		m =('ERR_LOGIN' + utilizador)
 			sock.sendall(m.enconde('utf-8'))
            ficheiro.close()

    elif comando == 'PUBLICMSGS':

    	ficheiroP = open("msgPublicas.txt")
    	if ficheiroP is None:
    		print('NO_PUBLICMSGS')
    		ficheiroP.close()

    	else:
    		print(ficheiroP)
    		ficheiroP()

	elif comando == 'SENDMSG':

		ficheiroP = open("msgPublicas.txt")
		if len(informacao) > 500:
			print('ERR_MSG_NOTSENT')
			ficheiroP.close()
		else:
			ficheiroP.write('\n' + informacao + '\n')
			print('OK_MSG_SENT')
			ficheiroP.close()

	elif comando == 'SENDPRIVMSG':

		utilizador, senha = informacao.split(' ',1)
		if utilizador not in open("utilizadores.txt"):
			print('ERR_PRIVMSG_NOTSENT')
			close()

		else:
			utilizador, informacao, data, hora = message_received_client.split(' ',3)
			utilizadorFicheiro = utilizador + '.txt'
			ficheiroUtilizador = open(utilizadorFicheiro)
			ficheiroUtilizador.write('\n' + data + ' ' + hora + ' ' + utilizador + ' '+ informacao + '\n')
			print ('MESSAGE_RECEIVED')
			ficheiroUtilizador.close()


    elif comando == 'PRIVMSGS':

    	ficheiroUtilizador = open(utilizadorFicheiro)
    	if ficheiroUtilizador is None:
    		print('NO_PRIVMSGS')
    		ficheiroUtilizador.close()

    	else:
    		print(ficheiroUtilizador)
    		ficheiroP()


	elif comando == 'GOODBYE':
		server.socket.close()

if __name__=="__main__": #ligar ao server
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	s.bind(("0.0.0.0", PORT)) #aceita todas as ligações
	s.listen(10)
	s.setblocking(0)

	SOCKET_LIST.append(s)

	#falta o print

	while True: #loop do server

		#remove sockets fechados
		for sock in SOCKET_LIST:
			if sock.fileno() < 0:
				SOCKET_LIST.remove(sock)

		rsocks,wsocks,esocks = select.select(SOCKET_LIST,[],[])

		for sock in rsocks: #sockets com novos dados

			if sock == s: #novo user
				newsock, addr = s.accept()
				newsock.setblocking(0)
				SOCKET_LIST.append(newsock)

				print ("Novo User - %s" % (addr,)) 

			else: #já existem dados
				try:
					data = sock.recv(RECV_BUFFER)
					if data:
						process_cmd (data,sock)

					else:
						print("O cliente desconectou")
						sock.close()
						SOCKET_LIST.remove(sock)

				except Exception as e:
					print("O cliente desconectou")
					sock.close()
					SOCKET_LIST.remove(sock)

