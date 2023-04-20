:- lib(ic).
:- lib(flat).

sortuj([],[]).
sortuj([A],[A]).
sortuj(Lista,Posortowane) :- 
    split(Lista,L1,L2),
    sortuj(L1,Res1),
    sortuj(L2,Res2),
    merg(Res1,Res2,Posortowane).

split([],[],[]).
split([A],[],[A]).
split([A,B|RR],[A|R1],[B|R2]) :- split(RR,R1,R2).

merg(A,[],A).
merg([],B,B).
merg([X1|R1],[X2|R2],[X2|Res]) :- X1 < X2, merg([X1|R1],R2,Res).
merg([X1|R1],[X2|R2],[X1|Res]) :- X1 >= X2, merg(R1,[X2|R2],Res).

minus1(List,0,List).
minus1([S|List],A,[X|Wyn]):-
    X is S - 1,
    X >= 0,
    N is A - 1,
    minus1(List,N,Wyn)
.

graficzny([0|_],"graf jest graficzny").
graficzny([A|Res],Odp) :-
    minus1(Res,A,Wyn),
    sortuj(Wyn,R),
    graficzny(R,Odp)
.
graficzny(L,"graf nie jest graficzny").


dfs([],"Graf jest pusty").
dfs(A,"Graf jest niespójny") :- member(0, A).
dfs(A,Wyn) :- 
    graficzny(A,"graf jest graficzny"),
    length(A, Int),
    list_to_plus(A,N),
    (N >= 2*(Int-1)
.
dfs(A,"Graf jest niespójny").