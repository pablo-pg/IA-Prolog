% Ejercicio 1:
% Definir la relación 'invertir(?L1,?L2)' que se verifique si la lista L2 es
% equivalente a la L1 pero con los elementos en orden inverso. Utilizar la
% técnica del acumulador para ello.
% Por ejemplo, invertir([9, 3, 1, 5] , L) debe dar L = [5, 1, 3, 9].

invertir(L1,L2) :- invertiracc(L1, [], L2).
    
invertiracc([], A, A).
invertiracc([H|T], A, L2) :- invertiracc(T, [H|A], L2).


% Ejercicio 2:
% Definir la relación 'suma(+L,?X)' y 'suma_acc(+L,?X)' que se verifiquen
% si X es la suma de los elementos de la lista de números L. Ha de implementarse
% el primero sin acumulador y el segundo con.
% Por ejemplo, suma([9, 3, 1, 5] , X) debe dar X = 18.

suma([], 0).
suma([H|T],X) :- suma(T, Y), X is Y + H.

suma_acc(L, X) :- acc_sum(L, 0, X).
acc_sum([], A, A).
acc_sum([H|T], A, X) :- Y is A + H, acc_sum(T, Y, X).


% Ejercicio 3:
% Implementar la búsqueda de solución para el juego Torres de Hanói con tres
% postes y un número indefinido N de discos, de forma que 'hanoi(+N,?L)'
% devuelva en L una lista de movimientos para resolver el problema.
% Ha de implementarse tres variantes: sin acumulador 'hanoi/2', con acumulador
% 'hanoi_acc/2'y con estructura en diferencia 'hanoi_dif/2'.
% Por ejemplo, hanoi(3,L) debe dar L = [mover(1, 3), mover(1, 2), mover(3, 2), mover(1, 3), mover(2, 1), mover(2, 3), mover(1, 3)].


hanoi(N, L) :- move(N, "1", "2", "3", L).
move(0,_,_,_,[]).
move(N,A,B,C,Moves):-
    N1 is N-1,
    move(N1,A,C,B,Moves1),
    move(N1,B,A,C,Moves2),
    to_str(Text,A,C),
    append(Moves1,[Text|Moves2],Moves).

to_str(R,X,Y) :-  addfirst(B,X), addsecond(B,Y, R).
addfirst(B,X) :- string_concat("mover(", X, B).
addsecond(B,Y,R):- string_concat(B,", ", A), string_concat(A, Y, C), string_concat(C, ")", R).



% Creo que no funciona
hanoi_acc(N,L) :- move_acc(N, "1", "2", "3", [], L).

move_acc(1,_,_,_, L, L).
move_acc(1,X,Y,_, [H|T], L) :-
    to_str(B,X,Y), append(L1,[B],L), L1 = L.
    to_str(B,X,Y), write(B).
move_acc(N,X,Y,Z, L1, L) :-
   N > 1,
   M is N-1,
   move_acc(M,X,Z,Y, L1, L),
   move_acc(1,X,Y,_, L1, L),
   move_acc(M,Z,Y,X, L1, L).

to_str(R,X,Y) :-  addfirst(B,X), addsecond(B,Y, R).
addfirst(B,X) :- string_concat("mover(", X, B).
addsecond(B,Y,R):- string_concat(B,", ", A), string_concat(A, Y, C), string_concat(C, ")", R)..