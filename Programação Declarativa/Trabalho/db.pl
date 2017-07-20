:- dynamic(peca/3).
%peças brancas

peca(peao, branco, 12).
peca(peao, branco, 22).
peca(peao, branco, 32).
peca(peao, branco, 42).
peca(peao, branco, 52).
peca(peao, branco, 62).
peca(peao, branco, 72).
peca(peao, branco, 82).
peca(torre, branco, 11).
peca(torre, branco, 81).
peca(cavalo, branco, 21).
peca(cavalo, branco, 71).
peca(bispo, branco, 31).
peca(bispo, branco, 61).
peca(rei, branco, 51).
peca(rainha, branco, 41).

%peças pretas
peca(peao, preto, 17).
peca(peao, preto, 27).
peca(peao, preto, 37).
peca(peao, preto, 47).
peca(peao, preto, 57).
peca(peao, preto, 67).
peca(peao, preto, 77).
peca(peao, preto, 87).
peca(torre, preto, 18).
peca(torre, preto, 88).
peca(cavalo, preto, 28).
peca(cavalo, preto, 78).
peca(bispo, preto, 38).
peca(bispo, preto, 68).
peca(rei, preto, 58).
peca(rainha, preto, 48).

%limita os valores recidos
dominio('1', 1).
dominio('2', 2).
dominio('3', 3).
dominio('4', 4).
dominio('5', 5).
dominio('6', 6).
dominio('7', 7).
dominio('8', 8).

%movimenta as peças
mover(PI, PF) :-
  peca(N,C,PI),
  assertz(peca(N,C,PF)),
  retract(peca(N,C,PI)).

%resolve o problema de mover uma peça para uma posição que ainda nao existe
mover(PI, PF) :-
  peca(N,C,PI),
  retract(peca(_,_,PF)),
  assertz(peca(N,C,PF)),
  retract(peca(N,C,PI)).


jogadaInvalida(_) :-
  write('Jogada impossivel').

%função que trata do movimento das torres no sentido vertical
torreV(Cor, PI, PF) :-
  peca(torre,Cor,PI),
  X = PF - PI,
  ((X =< 7 ) -> mover(PI, PF);
  jogadaInvalida(_)).

%funçao que trata do movimento das torres na horizontal
torreH(Cor, PI, PF) :-
  peca(torre, Cor, PI),
  number_chars(PI, [_|X1]),
  number_chars(PF, [_|X2]),
  ((X1 = X2 -> mover(PI, PF));
  jogadaInvalida(_)).

%movienta o rei na vertical
rei(PI, PF) :-
  peca(rei, C, PI),
  X = PF - PI,
  \+peca(_,C,PF),
  (((X =:= 1 ;X =:= -1 ) -> mover(PI, PF));
  jogadaInvalida(_)).

%movienta o rei na horizontal
rei(PI, PF) :-
  peca(rei, _, PI),
  X = PF - PI,
  \+peca(_,C,PF),
  (((X =:= 10 ;X =:= -10 )-> mover(PI, PF));
  jogadaInvalida(_)).


rei(PI, PF) :-
  peca(rei, _, PI),
  X = PF - PI,
  \+peca(_,C,PF),
  (((X =:= 11 ;X =:= -9 )-> mover(PI, PF));
  jogadaInvalida(_)).


% diagonais para baixo
rei(PI, PF) :-
  peca(rei, _, PI),
  X = PF - PI,
  \+peca(_,C,PF),
  (((X =:= 9 ;X =:= -11 )-> mover(PI, PF));
  jogadaInvalida(_)).


%movienta o rei na vertical
cavaloV(Cor, PI, PF) :-
  peca(cavalo, Cor, PI),
  \+peca(_,_,PF),
  X = PF - PI,
  (((X =:= 8; X=:= -8; X =:= 12; X =:= -12) -> mover(PI, PF));
  jogadaInvalida(_)).

%movienta o cavalo na horizontal
cavaloH(Cor, PI, PF) :-
  peca(cavalo, Cor, PI),
  X = PF - PI,
  (((X =:= 21; X=:= -21; X =:= 19; X =:= -19) -> mover(PI, PF));
  jogadaInvalida(_)).

  bispo(PI, PF,M) :-
    peca(bispo, C1, M),
    Y is PI + 11,
    \+peca(_,C, Y),
    bispo(Y, PF,M).

  bispo(PI, PF, M) :-
    peca(bispo, C1, M),
    Y is PI - 11,
    \+peca(_,C, Y),
    bispo(Y, PF, M).

  bispo(PI, PF, M) :-
    peca(bispo, C1, M),
    Y is PI + 9,
    \+peca(_,C, Y),
    bispo(Y, PF, M).

  bispo(PI, PF, M) :-
    peca(bispo, C1, M),
    Y is PI - 9,
    \+peca(_,C, Y),
    bispo(Y, PF,M).
