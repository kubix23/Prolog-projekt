%:- style_check(-singleton).
%^ Odkomentowac linijkę wyżej dla innego kompilatora niż Eclipse
%Wyrównanie Poziomu zagłębienia Listy = WPL
czy_wygrywa(Plansza) :- atomics_to_string(Plansza,',',S),printf('S:%s\n',[S]), %Wypisanie pozycji początkowej
                        a(Plansza). %Wywołanie do ruchów gracza a
a(A) :- ruchy_aF([],A). %Generowanie ruchów gracza a z WPL

ruchy_aF(P,T) :- flatten(P,Res1),flatten(T,Res2),ruchy_a(Res1,Res2). %predykat wykonujący WPL i wywołujący generowanie ruchów a
ruchy_a(P,[0|A]) :-  ruchy_aF([P,0],A). % przesuwanie wskaźnika przez puste pola planszy
ruchy_a(P,[1|[0|A]]) :- (flatten([P|[0|[1|A]]],Res),atomics_to_string(Res,',',S),printf('A:%s\n',[S])) %wypisanie planszy z ruchem gracza a
                        ,(b([],Res); ruchy_aF([P|1],[0|A])). %Wywołanie do ruchów gracza b z plaszą z wykonanym ruchem gracza a i generowanie dalszych ruchów gracza a z WPL
ruchy_a(P,[2|[0|A]]) :- (flatten([P|[1|[1|A]]],Res),atomics_to_string(Res,',',S),printf('A:%s\n',[S])) %wypisanie planszy z ruchem gracza a
                        ,(b([],Res); ruchy_aF([P|2],[0|A])). %Wywołanie do ruchów gracza b z plaszą z wykonanym ruchem gracza a i generowanie dalszych ruchów gracza a z WPL

%jump
ruchy_a(P, [1|[1|A]]) :- ((skocz_a([P|[0]],[1|A],Res), atomics_to_string(Res,',',S),printf('A:%s\n',[S]))) %wypisanie planszy z ruchem gracza a(po skoku)
                        ,(b([],Res); ruchy_aF([P|1],[1|A])). %Wywołanie do ruchów gracza b z plaszą z wykonanym ruchem gracza a(skoku) i generowanie dalszych ruchów gracza a z WPL
ruchy_a(P, [2|[1|A]]) :- ((skocz_a([P|[1]],[1|A],Res), atomics_to_string(Res,',',S),printf('A:%s\n',[S]))) %wypisanie planszy z ruchem gracza a(po skoku)
                        ,(b([],Res); ruchy_aF([P|2],[1|A])). %Wywołanie do ruchów gracza b z plaszą z wykonanym ruchem gracza a(skoku) i generowanie dalszych ruchów gracza a z WPL
ruchy_a(P, [1|[2|A]]) :- ((skocz_a([P|[0]],[2|A],Res), atomics_to_string(Res,',',S),printf('A:%s\n',[S]))) %wypisanie planszy z ruchem gracza a(po skoku)
                        ,(b([],Res); ruchy_aF([P|1],[2|A])). %Wywołanie do ruchów gracza b z plaszą z wykonanym ruchem gracza a(skoku) i generowanie dalszych ruchów gracza a z WPL
ruchy_a(P, [2|[2|A]]) :- ((skocz_a([P|[1]],[2|A],Res), atomics_to_string(Res,',',S),printf('A:%s\n',[S]))) %wypisanie planszy z ruchem gracza a(po skoku)
                        ,(b([],Res); ruchy_aF([P|2],[2|A])). %Wywołanie do ruchów gracza b z plaszą z wykonanym ruchem gracza a(skoku) i generowanie dalszych ruchów gracza a z WPL
ruchy_a(_,_) :- print('\n'),false. %Wstawienie enterów na końcu ruchu gracza a

skocz_a(P,[0|A], Res) :- flatten([P|[1|A]],Res). %wstawienie 1 w pierwsze wolne miejsce i WPL
skocz_a(P,[I|A],R) :- skocz_a([P|I],A,R). %sprawdzanie kolejnych pól planszy w celu szukania 0

b(P,[0|A]) :- b([P|0],A). %sprawdzanie kolejnych pól planszy w celu szukania pierwszego pionka
b(P,[1|[1|A]]) :-  flatten([P|[0|[2|A]]],Res),atomics_to_string(Res,',',S),printf('B:%s\n',[S]) %wypisanie planszy z ruchem gracza b
                ,a(Res), ruchy_bF([P|0],[2|A]). %Wywołanie do ruchów gracza a z plaszą z wykonanym skrajnym ruchem gracza b i generowanie dalszych ruchów gracza b z WPL
b(P,[2|[1|A]]) :-  flatten([P|[1|[2|A]]],Res),atomics_to_string(Res,',',S),printf('B:%s\n',[S]) %wypisanie planszy z ruchem gracza b
                ,a(Res), ruchy_bF([P|1],[2|A]). %Wywołanie do ruchów gracza a z plaszą z wykonanym skrajnym ruchem gracza b i generowanie dalszych ruchów gracza b z WPL
b(P,[1|[0|A]]) :-  flatten([P[0|[1|A]]],Res),atomics_to_string(Res,',',S),printf('B:%s\n',[S]) %wypisanie planszy z ruchem gracza b
                ,a(Res), ruchy_bF([P|0],[1|A]). %Wywołanie do ruchów gracza a z plaszą z wykonanym skrajnym ruchem gracza b i generowanie dalszych ruchów gracza b z WPL
b(P,[2|[0|A]]) :-  flatten([P|[1|[1|A]]],Res),atomics_to_string(Res,',',S),printf('B:%s\n',[S]) %wypisanie planszy z ruchem gracza b
                ,a(Res), ruchy_bF([P|1],[1|A]). %Wywołanie do ruchów gracza a z plaszą z wykonanym skrajnym ruchem gracza b i generowanie dalszych ruchów gracza b z WPL
b(_,[1,2|_]). %prawda, ponieważ gracz b nie ma ruchu czyli to jest wygrywająca sytuacja dla gracza a
b(_,[2,2|_]). %prawda, ponieważ gracz b nie ma ruchu czyli to jest wygrywająca sytuacja dla gracza a
b(_,[1]). %prawda, ponieważ gracz b nie ma ruchu czyli to jest wygrywająca sytuacja dla gracza a
b(_,[2]). %prawda, ponieważ gracz b nie ma ruchu czyli to jest wygrywająca sytuacja dla gracza a
b(_,[]). %prawda, ponieważ gracz b nie ma ruchu czyli to jest wygrywająca sytuacja dla gracza a

ruchy_bF(P,T) :- flatten(P,Res1),flatten(T,Res2),generuj_ruchy_b(Res1,Res2). %predykat wykonujący WPL i wywołujący generowanie ruchów b

generuj_ruchy_b(P, [1|[1|A]]) :- flatten([P|[2|A]],Res), atomics_to_string(Res,',',S),printf('B:%s\n',[S]) %wypisanie planszy z ruchem gracza b
                                ,a(Res) , ruchy_bF([P|1],[1|A]). %Wywołanie do ruchów gracza a z plaszą z wykonanym ruchem gracza b i generowanie dalszych ruchów gracza b z WPL
generuj_ruchy_b(P, [2|[1|A]]) :- flatten([P|[1|[2|A]]],Res), atomics_to_string(Res,',',S),printf('B:%s\n',[S]) %wypisanie planszy z ruchem gracza b
                                ,a(Res) , ruchy_bF([P|2],[1|A]). %Wywołanie do ruchów gracza a z plaszą z wykonanym ruchem gracza b i generowanie dalszych ruchów gracza b z WPL
generuj_ruchy_b(P, [1|[0|A]]) :- flatten([P|[1|A]],Res), atomics_to_string(Res,',',S),printf('B:%s\n',[S]) %wypisanie planszy z ruchem gracza b
                                ,a(Res) , ruchy_bF([P|1],[0|A]). %Wywołanie do ruchów gracza a z plaszą z wykonanym ruchem gracza b i generowanie dalszych ruchów gracza b z WPL
generuj_ruchy_b(P, [2|[0|A]]) :- flatten([P|[1|[1|A]]],Res), atomics_to_string(Res,',',S),printf('B:%s\n',[S]) %wypisanie planszy z ruchem gracza b
                                ,a(Res) , ruchy_bF([P|2],[0|A]). %Wywołanie do ruchów gracza a z plaszą z wykonanym ruchem gracza b i generowanie dalszych ruchów gracza b z WPL
generuj_ruchy_b(P, [1,2|_]). %prawda, ponieważ gracz b nie ma ruchu czyli to jest wygrywająca sytuacja dla gracza a
generuj_ruchy_b(P, [2,2|_]). %prawda, ponieważ gracz b nie ma ruchu czyli to jest wygrywająca sytuacja dla gracza a
generuj_ruchy_b(P, []). %prawda, ponieważ gracz b nie ma ruchu czyli to jest wygrywająca sytuacja dla gracza a
generuj_ruchy_b(P, [1]). %prawda, ponieważ gracz b nie ma ruchu czyli to jest wygrywająca sytuacja dla gracza a
generuj_ruchy_b(P, [2]). %prawda, ponieważ gracz b nie ma ruchu czyli to jest wygrywająca sytuacja dla gracza a