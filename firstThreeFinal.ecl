
sortuj(LIST,ODP) :- mergesort(LIST,ODP), !.
czy_graficzny(LIST,ODP) :- graphic(LIST,ODP),!.
czy_spojny(LIST,ODP) :- connected(LIST,ODP), !.


% Łączenie dwóch list tak, aby większe elementy występowały wcześniej, część mergesortu. Trzeci argument to wynik.
merging([],L,L).
merging(L,[],L).
merging([X|L1],[Y|L2],[Y|ANS]) :- X=<Y, merging([X|L1],L2,ANS),!.
merging([X|L1],[Y|L2],[X|ANS]) :- X>Y, merging(L1,[Y|L2],ANS),!.

% Konkatenacja dwóch list, trzeci argument to wynik
dolacz( [],L,L ).
dolacz( [H|T],L,[H|X] ) :- dolacz( T,L,X ). % rekurencyjne dołączanie  pierwszego argumentu pierwszej listy do wynikowej tablicy

%podział listy na pół (jedna odpowiedź)
%Znajdowanie list L i R , które łączą się w oryginalną, o długości połowy oryginalnej listy
splitHalf(LIST,L,R) :- dolacz(L,R,LIST), length(L,LENL), length(R,LENR), (LENL=LENR; LENL is LENR + 1), !.


%mergesort nierosnący
mergesort(LIST,LIST) :- length(LIST,LEN), LEN < 2. %jeśli lista ma długość mniejszą od 2, to już jest posortowana
%podział listy na pół, sortowanie każdej z nich, i łączenie mergingiem
mergesort(LIST,ANS) :- splitHalf(LIST, L, R), mergesort(L, LANS), mergesort(R,RANS), merging(LANS, RANS, ANS), !. 


% zmniejszenie NUM pierwszych elementów listy  L o 1
%decList(L,NUM,ODP)
decList(L,0,L). % warunek końcowy
decList([],NUM,[]). % Gdy liczba przewyższa liczbę elementów, wszystkie będą zmniejszone
%rekurencyjne zmniejszanie liczby i zmniejszanie kolejnych elementów listy
decList([H|L],NUM,[H1|ANS]) :- H1 is H-1,N is NUM-1, decList(L,N,ANS),!.


% ustalenie czy ciąg jest graficzny
graphic([],"Y"). %pusty graf 
% Sortowanie, Usuwanie pierwszej (największej) liczby i decList o tę liczbę listy.
graphic(LIST,"Y") :- mergesort(LIST,LSORT), LSORT = [H|L], length(L,LEN), (H>=0, LEN >= H), decList(L,H,RES), graphic(RES,"Y").
% Jeśli w którymś momencie któryś z elementów byłby ujemny, lub większy od długości, to ciąg nie jest graficzny
graphic(LIST, "N") :- \+ graphic(LIST,"Y"). 


%suma elementów listy
sumElements([],0).
%Rekurencyjna suma 
sumElements([H|L], ANS) :- sumElements(L,ANS2), ANS is ANS2 + H .

%sprawdzanie czy lista posiada element zerowy
hasZero([],"N"). %jeśli przeszukalibyśmy całą listę, to 
hasZero([H|L],"Y") :- H=0. % jeśli pierwszy element to zero, to lista ma zero
hasZero([H|L],ANS) :- (H=\=0), hasZero(L,ANS), !. % jeśli pierwszy element to nie zero, "szukamy dalej", jak znajdzie jakiś zero, kończy

%Sprawdzanie czy graf jest spójny
connected(LIST,"N") :- \+ connected(LIST,"Y"), !. %Jeśli nie da się udowodnić spójności, to nie jest spójny
connected(LIST,"Y") :- length(LIST,LEN), ((\+ hasZero(LIST,"Y")); LEN < 2), %Jeśli graf nie ma zera (lub ma mniej niż dwa elementy)
    graphic(LIST,"Y"), %Jest graficzny
    sumElements(LIST,SUM), SUM >= 2*(LEN-1), !. % Oraz suma stopni jest nie mniejsza od 2(n-1)
	%to ciąg wyznacza graf spójny