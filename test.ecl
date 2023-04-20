%:- style_check(-singleton).
czy_wygrywa(Plansza) :- atomics_to_string(Plansza,',',S),printf('S:%s\n',[S]),
                        a(Plansza).
a(A) :- ruchy_aF([],A).

ruchy_aF(P,T) :- flatten(P,Res1),flatten(T,Res2),ruchy_a(Res1,Res2).
ruchy_a(P,[0|A]) :-  ruchy_aF([P,0],A).
ruchy_a(P,[1|[0|A]]) :- (flatten([P|[0|[1|A]]],Res),atomics_to_string(Res,',',S),printf('A:%s\n',[S]))
                        ,(b([],Res); ruchy_aF([P|1],[0|A])).
ruchy_a(P,[2|[0|A]]) :- (flatten([P|[1|[1|A]]],Res),atomics_to_string(Res,',',S),printf('A:%s\n',[S]))
                        ,(b([],Res); ruchy_aF([P|2],[0|A])).

%jump
ruchy_a(P, [1|[1|A]]) :- ((skocz_a([P|[0]],[1|A],Res), atomics_to_string(Res,',',S),printf('A:%s\n',[S])))
                        ,(b([],Res); ruchy_aF([P|1],[1|A])).
ruchy_a(P, [2|[1|A]]) :- ((skocz_a([P|[1]],[1|A],Res), atomics_to_string(Res,',',S),printf('A:%s\n',[S])))
                        ,(b([],Res); ruchy_aF([P|2],[1|A])).
ruchy_a(P, [1|[2|A]]) :- ((skocz_a([P|[0]],[2|A],Res), atomics_to_string(Res,',',S),printf('A:%s\n',[S])))
                        ,(b([],Res); ruchy_aF([P|1],[2|A])).
ruchy_a(P, [2|[2|A]]) :- ((skocz_a([P|[1]],[2|A],Res), atomics_to_string(Res,',',S),printf('A:%s\n',[S])))
                        ,(b([],Res); ruchy_aF([P|2],[2|A])).
ruchy_a(_,_) :- print('\n'),false.

skocz_a(P,[0|A], Res) :- flatten([P|[1|A]],Res).
skocz_a(P,[I|A],R) :- skocz_a([P|I],A,R).

b(P,[0|A]) :- b([P|0],A).
b(P,[1|[1|A]]) :-  flatten([P|[0|[2|A]]],Res),atomics_to_string(Res,',',S),printf('B:%s\n',[S])
                ,a(Res), ruchy_bF([P|0],[2|A]).
b(P,[2|[1|A]]) :-  flatten([P|[1|[2|A]]],Res),atomics_to_string(Res,',',S),printf('B:%s\n',[S])
                ,a(Res), ruchy_bF([P|1],[2|A]).
b(P,[1|[0|A]]) :-  flatten([P[0|[1|A]]],Res),atomics_to_string(Res,',',S),printf('B:%s\n',[S])
                ,a(Res), ruchy_bF([P|0],[1|A]).
b(P,[2|[0|A]]) :-  flatten([P|[1|[1|A]]],Res),atomics_to_string(Res,',',S),printf('B:%s\n',[S])
                ,a(Res), ruchy_bF([P|1],[1|A]).
b(_,[1,2|_]).
b(_,[2,2|_]).
b(_,[1]).
b(_,[2]).
b(_,[]).

ruchy_bF(P,T) :- flatten(P,Res1),flatten(T,Res2),generuj_ruchy_b(Res1,Res2).

generuj_ruchy_b(P, [1|[1|A]]) :- flatten([P|[2|A]],Res), atomics_to_string(Res,',',S),printf('B:%s\n',[S])
                                ,a(Res) , ruchy_bF([P|1],[1|A]).
generuj_ruchy_b(P, [2|[1|A]]) :- flatten([P|[1|[2|A]]],Res), atomics_to_string(Res,',',S),printf('B:%s\n',[S])
                                ,a(Res) , ruchy_bF([P|2],[1|A]).
generuj_ruchy_b(P, [1|[0|A]]) :- flatten([P|[1|A]],Res), atomics_to_string(Res,',',S),printf('B:%s\n',[S])
                                ,a(Res) , ruchy_bF([P|1],[0|A]).
generuj_ruchy_b(P, [2|[0|A]]) :- flatten([P|[1|[1|A]]],Res), atomics_to_string(Res,',',S),printf('B:%s\n',[S])
                                ,a(Res) , ruchy_bF([P|2],[0|A]).
generuj_ruchy_b(P, [1,2|_]).
generuj_ruchy_b(P, [2,2|_]).
generuj_ruchy_b(P, []).
generuj_ruchy_b(P, [1]).
generuj_ruchy_b(P, [2]).