% Ejercicio 1:
% Definir la relación 'min_lista(+L,?X)' que se verifique si X es
% el mínimo de la lista de números L. Por ejemplo, min_lista([9 ,3 ,1 ,5] , X)
% debe dar X = 1.

min_lista(L, X) :- [Y|Ls] = L, min_lista(Ls, Y, X).

min_lista([], X, X).
min_lista(L, X0, X) :- [Y|Ls] = L, X1 is min(Y, X0), min_lista(Ls, X1, X).

% Ejercicio 2:
% Definir la relación 'cuadrado(+L1,?L2)' donde L1 es una lista constituida por
% números y que se verifique si L2 está constituida por los números equivalentes
% de la lista L1 elevados al cuadrado. Por ejemplo, cuadrado([1, 2, 3], L2)
% debe dar L2 = [1, 4, 9].

cuadrado([],[]).
cuadrado([Y1|Ls1], [Y2|Ls2]):- T is Y1 * Y1, T = Y2, cuadrado(Ls1, Ls2).

% Ejercicio 3:
% Definir la relación 'entrelaza(?L1,?L2,?L)' que se verifique si la lista L está
% constituida por los elementos entrelazados de las listas L1 y L2, que han de
% tener igual longitud. Por ejemplo, entrelaza([1, 3, 5], [2, 4, 6], L) debe dar
% L = [1, 2, 3, 4, 5, 6].

misma_longitud([],[]).
misma_longitud([_|L1],[_|L2]) :- misma_longitud(L1, L2).

entrelaza([],C, C).
entrelaza(C,[], C).
entrelaza([A|L1],[B|L2], [A,B|L3]):- misma_longitud([A|L1],[B|L2]) , entrelaza(L1,L2,L3).

% Ejercicio 4:
% Definir la relación 'subtramo(?L1,?L2)' que se verifique si la lista L1 es un
% subtramo ordenado listas L2. Por ejemplo, subtramo([3, 4, 5], [1, 2, 3, 4, 5, 6])
% debe dar true.

subtramo([],_).
subtramo([A|L1],[A|L2]) :- subtramo(L1,L2).
subtramo([A|L1],[_|L2]) :- subtramo([A|L1],L2).


% Ejercicio 5:
% Definir la relación 'previo(?X,?Y,+L)' que se verifique si X está antes que Y
% en la lista L. Por ejemplo, previo(b, e, [a, b, c, d , e, f]) debe dar true.

buscar(B,[B|_]).
buscar(B,[_|L]):- buscar(B,L).

previo(A,B,[A,B|_]).
previo(A,B,[A|L]) :- buscar(B, L).
previo(A, B, [_|L]):- previo(A,B,L).

% Ejercicio 6:
% Definir la relación 'aplana(+L1,?L2)' que se verifique si L2 es la lista
% equivalente a L1 donde se han eliminado todos su anidamientos.
% Por ejemplo, aplana([a, b, [c, [d], [], e], f], L) debe dar L = [a, b, c, d, e, f].

insertar(X,[X|L], L).
% insertar(X,L2, L):- L2 = [X|L].
insertar(X, L1,L2):- append(L1,[X],L2).
aplana_aux([],[], []).
aplana_aux(A,L2, L3):- not(is_list(A)), insertar(A,L2,L3).
aplana_aux([A|_],L2,L3):- is_list(A), aplana_aux(A,L2, L3).
aplana([],_).
aplana([A|L1], L2):- aplana_aux(A,[],L2), aplana(L1,L2).