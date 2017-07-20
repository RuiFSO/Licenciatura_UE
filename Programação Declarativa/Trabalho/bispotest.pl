:- [trabalho].

bispo(PI,PF) :-


validatebishop(Coord, Coord).
validatebishop([OCol|OLin], [DCol|DLin]) :-
    (OCol < DCol, NewCol is OCol+1; OCol > DCol, NewCol is OCol-1),
    (OLin < DLin, NewLin is OLin+1; OLin > DLin, NewLin is OLin-1),
    (\+ pos(_, _, NewCol, NewLin); [NewCol|NewLin] == [DCol|DLin]), !,
    validatebishop([NewCol|NewLin], [DCol|DLin]).
