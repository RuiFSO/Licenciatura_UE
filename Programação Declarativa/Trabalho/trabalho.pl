:- dynamic(peca/3).

%Peças Brancas
peca(peao,branca,12).
peca(peao,branca,22).
peca(peao,branca,32).
peca(peao,branca,42).
peca(peao,branca,52).
peca(peao,branca,62).
peca(peao,branca,72).
peca(peao,branca,82).
peca(torre,branca,11).
peca(torre,branca,81).
peca(cavalo,branca,21).
peca(cavalo,branca,71).
peca(bispo,branca,31).
peca(bispo,branca,61).
peca(rei,branca,51).
peca(rainha,branca,41).

%Peças Pretas
peca(peao,preta,17).
peca(peao,preta,27).
peca(peao,preta,37).
peca(peao,preta,47).
peca(peao,preta,57).
peca(peao,preta,67).
peca(peao,preta,77).
peca(peao,preta,87).
peca(torre,preta,18).
peca(torre,preta,88).
peca(cavalo,preta,28).
peca(cavalo,preta,78).
peca(bispo,preta,38).
peca(bispo,preta,68).
peca(rei,preta,58).
peca(rainha,preta,48).

dominio(['1'],1).
dominio(['2'],2).
dominio(['3'],3).
dominio(['4'],4).
dominio(['5'],5).
dominio(['6'],6).
dominio(['7'],7).
dominio(['8'],8).

mover(PI,PF):-
	peca(N,C,PI),
	peca(N1,C1,PF),
	C \= C1,
	retract(peca(N1,C1,PF)),
	assertz(peca(N,C,PF)),
	retract(peca(N,C,PI)).

mover(PI,PF):-
	peca(N,C,PI),
	assertz(peca(N,C,PF)),
	retract(peca(N,C,PI)).

jogadaInvalida(_) :-
  write('Jogada impossivel').

%--------------------Peões---------------------
%--------------------Branco--------------------
peao_branco(PI,PF):-
	 number_chars(PI,[X1|X2]),
	 dominio(X2,Y),
	 peca(peao,branca,PI),
	 \+peca(_,_,PF),
	 (Y = 2 -> PF is PI+1),
	 mover(PI,PF).

peao_branco(PI,PF):-
	 number_chars(PI,[X1|X2]),
	 dominio(X2,Y),
	 peca(peao,branca,PI),
	 \+peca(_,_,PF),
	 (Y = 2 -> PF is PI+2),
	 mover(PI,PF).

peao_branco(PI,PF):-
	 number_chars(PI,[X1|X2]),
	 dominio(X2,Y),
	 peca(peao,branca,PI),
	 peca(_,preta,PF),
	 PF is PI-9,
	 mover(PI,PF).

peao_branco(PI,PF):-
	 number_chars(PI,[X1|X2]),
	 dominio(X2,Y),
	 peca(peao,branca,PI),
	 peca(_,preta,PF),
	 PF is PI+11,
	 mover(PI,PF).

peao_branco(PI,PF):-
	 number_chars(PI,[X1|X2]),
	 dominio(X2,Y),
	 peca(peao,branca,PI),
	 \+peca(_,_,PF),
	 PF is PI +1,
	 mover(PI,PF).

%--------------------Preto--------------------
peao_preto(PI,PF):-
	 number_chars(PI,[X1|X2]),
	 dominio(X2,Y),
	 peca(peao,preta,PI),
	 \+peca(_,_,PF),
	 (Y = 7 -> PF is PI-1),
	 mover(PI,PF).

peao_preto(PI,PF):-
	 number_chars(PI,[X1|X2]),
	 dominio(X2,Y),
	 peca(peao,preta,PI),
	 \+peca(_,_,PF),
	 (Y = 7 -> PF is PI-2),
	 mover(PI,PF).

peao_preto(PI,PF):-
	 number_chars(PI,[X1|X2]),
	 peca(peao,preta,PI),
	 peca(_,branca,PF),
	 PF is PI+9,
	 mover(PI,PF).

peao_preto(PI,PF):-
	 number_chars(PI,[X1|X2]),
	 dominio(X2,Y),
	 peca(peao,preta,PI),
	 peca(_,branca,PF),
	 PF is PI-11,
	 mover(PI,PF).

peao_preto(PI,PF):-
	 number_chars(PI,[X1|X2]),
	 peca(peao,preta,PI),
	 \+peca(_,_,PF),
	 PF is PI -1,
	 mover(PI,PF).
%----------------------Rei--------------------------
%movienta o rei na vertical
rei(PI, PF) :-
  peca(rei, C, PI),
  X = PF - PI,
  \+peca(_,C,PF),
  ((X =:= 1 ;X =:= -1 ) -> mover(PI, PF)).

%movienta o rei na horizontal
rei(PI, PF) :-
  peca(rei, _, PI),
  X = PF - PI,
  \+peca(_,C,PF),
  ((X =:= 10 ;X =:= -10 )-> mover(PI, PF)).

%diagonais
rei(PI, PF) :-
  peca(rei, _, PI),
  X = PF - PI,
  \+peca(_,C,PF),
  ((X =:= 11 ;X =:= -11 )-> mover(PI, PF)).

% diagonais
rei(PI, PF) :-
  peca(rei, _, PI),
  X = PF - PI,
  \+peca(_,C,PF),
  ((X =:= 9 ;X =:= -9 )-> mover(PI, PF)).
%-----------------Cavalo----------------------------
cavalo(PI,PF) :-
 	peca(cavalo, _, PI),
	X = PF - PI,
	\+peca(_,_,PF),
  (((X =:= 8; X=:= -8; X =:= 12; X =:= -12) -> mover(PI, PF))).

cavalo(PI, PF) :-
  peca(cavalo, _, PI),
  	X = PF - PI,
	\+peca(_,_,PF),
  (((X =:= 21; X=:= -21; X =:= 19; X =:= -19) -> mover(PI, PF))).
%---------------Torre-------------------------------------
torre(PI,PF,PA):-
	PA=PF,
	mover(PI,PF).

%cima
torre(PI, PF,PA) :-
	PF>PI,
   peca(torre, C, PI),
   number_chars(PI, [X1|_]),
   number_chars(PF, [X2|_]),
   X1=X2,
   PA is PF+1,
   \+peca(_,C,PF),
   \+peca(_,C,PA),
   torre(PI,PF,PA).

%baixo
torre(PI, PF,PA) :-
	PF<PI,
   peca(torre, C, PI),
   number_chars(PI, [X1|_]),
   number_chars(PF, [X2|_]),
   X1=X2,
   PA is PF-1,
   \+peca(_,C,PF),
   \+peca(_,C,PA),
   torre(PI,PF,PA).

%direita
torre(PI, PF,PA) :-
	PF>PI,
   peca(torre, C, PI),
   number_chars(PI, [_|Y1]),
   number_chars(PF, [_|Y2]),
   Y1=Y2,
   PA is PF+10,
   \+peca(_,C,PF),
   \+peca(_,C,PA),
   torre(PI,PF,PA).

 %esquerda
torre(PI, PF,PA) :-
	PF<PI,
   peca(torre, C, PI),
   number_chars(PI, [_|Y1]),
   number_chars(PF, [_|Y2]),
   Y1=Y2,
   PA is PF-10,
   \+peca(_,C,PF),
   \+peca(_,C,PA),
   torre(PI,PF,PA).

%---------------Bispo-------------------------------------
bispo(PI,PF,PA):-
  PA=PF,
  mover(PI,PF).

% >^
bispo(PI, PF,PA) :-
  PF>PI,
   peca(bispo, C, PI),
   X1=X2,
   PA is PF+11,
   \+peca(_,C,PF),
   \+peca(_,C,PA),
   bispo(PI,PF,PA).

% >v
bispo(PI, PF,PA) :-
  PF<PI,
   peca(bispo, C, PI),
   X1=X2,
   PA is PF+9,
   \+peca(_,C,PF),
   \+peca(_,C,PA),
   bispo(PI,PF,PA).

% <^
bispo(PI, PF,PA) :-
  PF>PI,
   peca(bispo, C, PI),
   PA is PF-9,
   \+peca(_,C,PF),
   \+peca(_,C,PA),
   bispo(PI,PF,PA).

 % <v
bispo(PI, PF,PA) :-
  PF<PI,
   peca(bispo, C, PI),
   Y1=Y2,
   PA is PF-11,
   \+peca(_,C,PF),
   \+peca(_,C,PA),
   bispo(PI,PF,PA).

%----------------------Rainha---------------------
rainha(PI, PF, PA) :-
	torre(PI, PF, PA), !;
	bispo(PI, PF, PA).


%-----------------Print Tabuleiro--------------------
printTabuleiro([]):-
	write('.--.--.--.--.--.--.--.--.').
printTabuleiro([Linha|LinhaS]):-
	write('.--.--.--.--.--.--.--.--.'),
	nl,
	printLinha(Linha),
	write('|'),
	nl,
	printTabuleiro(LinhaS), !.

printLinha([]).
printLinha([Peca|PecaS]):-
	write('|'),
	((peca(N,C,Peca),
	printPeca(N,C),write(' '));
	write(' '), write(' ')),
	printLinha(PecaS).

printPeca(P,C) :-
  (P=rei,C=branca->write('♔');
  (P=rainha,C=branca->write('♕');
  (P=torre,C=branca->write('♖');
  (P=bispo,C=branca->write('♗');
  (P=cavalo,C=branca->write('♘');
  (P=peao,C=branca->write('♙');
  (P=rei,C=preta->write('♚');
  (P=rainha,C=preta->write('♛');
  (P=torre,C=preta->write('♜');
  (P=bispo,C=preta->write('♝');
  (P=cavalo,C=preta->write('♞');
  (P=peao,C=preta->write('♟');
  (write(' ');
  fail))))))))))))).

%---------------------gets--------------------------
gets(S) :-
	get0(C),
	gets([], C, S).
gets(S, 10, S).
gets(S, -1, S).
gets(I, C, [C|O]) :-
	get0(CC),
	gets(I, CC, O).

%----------------------Jogada----------------
jogada([]):-!.
jogada([10|_]):-!.
jogada(J):-
	J=[A,B,C,D|R],
	X is A-48,
	Y is B-48,
	Z is C-48,
	W is D-48,
	0<X,X<9,
	0<Y,Y<9,
	0<Z,Z<9,
	0<W,W<9,
	K is (X*10)+Y,
	L is (Z*10)+W,
	(peao_branco(K,L);
	 peao_preto(K,L);
	 cavalo(K,L);
	 rei(K,L);
	 torre(K,L,L);
	 write('jogada invalida')),
	jogada(R).

%---------------------Main--------------------
main:-
	shell(clear),
	printTabuleiro([[18,28,38,48,58,68,78,88],
				[17,27,37,47,57,67,77,87],
				[16,26,36,46,56,66,76,86],
				[15,25,35,45,55,65,75,85],
				[14,24,34,44,54,64,74,84],
				[13,23,33,43,53,63,73,83],
				[12,22,32,42,52,62,72,82],
				[11,21,31,41,51,61,71,81]]),
	nl,
	write('Insira Jogada:'),
	gets(J),
	jogada(J),
	printTabuleiro([[18,28,38,48,58,68,78,88],
				[17,27,37,47,57,67,77,87],
				[16,26,36,46,56,66,76,86],
				[15,25,35,45,55,65,75,85],
				[14,24,34,44,54,64,74,84],
				[13,23,33,43,53,63,73,83],
				[12,22,32,42,52,62,72,82],
				[11,21,31,41,51,61,71,81]]),
	main.
