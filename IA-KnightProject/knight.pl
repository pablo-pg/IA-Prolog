
% N es el número de filas/columnas del tablero
knight(N) :-
	Max is N * N,
	length(L, Max),
	write('Introduzca la posición de inicio del caballo'), nl,
	write('Posición en X: '), flush_output, read(Xpos), nl,
	write('Posición en Y: '), flush_output, read(Ypos), nl,
	Xpos1 is Xpos - 1, Ypos1 is Ypos - 1,
	knight(N, 0, Max, Xpos1, Ypos1, L),
	display(N, 0, L, 0).
 

% Si por algún casual no hay posible camino.
knight(_, Max, Max, _, _, _) :- !.

% NumCols : Número de columnas por línea
% N  : Número del movimiento actual
% MaxN   : Número máximo de movimientos posibles
% Xpos/Ypos : Posición actual del caballo
% L : El tablero representado en una lista
knight(NumCols, N, MaxN, Xpos, Ypos, L) :-
	% Compruebo bordes del tablero
	Xpos >= 0, Ypos >= 0, Xpos < NumCols, Ypos < NumCols,
 
	Pos is Xpos * NumCols + Ypos,
	N1 is N+1,
	% Comprueba si llevo tantos movimientos del caballo como llamdas recursivas
	nth0(Pos, L, N1),
  % De entre los posibles movimientos, me quedo el mejor
	XposM1 is Xpos - 1, XposM2 is Xpos - 2, XposP1 is Xpos + 1, XposP2 is Xpos + 2,
	YposM1 is Ypos - 1, YposM2 is Ypos - 2, YposP1 is Ypos + 1, YposP2 is Ypos + 2,
	maplist(best_move(NumCols, L),
		[(XposP1, YposM2), (XposP2, YposM1), (XposP2, YposP1),(XposP1, YposP2),
		 (XposM1, YposM2), (XposM2, YposM1), (XposM2, YposP1),(XposM1, YposP2)],
		R),
	sort(R, RS),
	pairs_values(RS, Moves),
	move(NumCols, N1, MaxN, Moves, L).
 

move(NumCols, N1, MaxN, [(Xpos, Ypos) | R], L) :-
	knight(NumCols, N1, MaxN, Xpos, Ypos, L);
	move(NumCols, N1, MaxN,  R, L).
 

%% Si no es posible el movimiento se pone un 1000 de valor
best_move(NumCols, _L, (Xpos, Ypos), 1000-(Xpos, Ypos)) :-
	(   Xpos < 0 ; Ypos < 0; Xpos >= NumCols; Ypos >= NumCols), !.
	
best_move(NumCols, L, (Xpos, Ypos), 1000-(Xpos, Ypos)) :-
	Pos is Xpos*NumCols+Ypos,
	% Obtengo el valor V, que es L[Pos]
	nth0(Pos, L, V),
	% Compruebo si V no es una variable (\+ es lo mismo que not/1, pero not/1 está obsoleto)
	\+var(V), !.
 

% Si el movimiento es posible se pone como valor el número de movimientos que puede hacer
best_move(NumCols, L, (Xpos, Ypos), R-(Xpos, Ypos)) :-
	XposM1 is Xpos - 1, XposM2 is Xpos - 2, XposP1 is Xpos + 1, XposP2 is Xpos + 2,
	YposM1 is Ypos - 1, YposM2 is Ypos - 2, YposP1 is Ypos + 1, YposP2 is Ypos + 2,
	include(possible_move(NumCols, L),
		[(XposP1, YposM2), (XposP2, YposM1), (XposP2, YposP1),(XposP1, YposP2),
		 (XposM1, YposM2), (XposM2, YposM1), (XposM2, YposP1),(XposM1, YposP2)],
		LPosibles),       %< Lista de todos los movimientos posibles
	length(LPosibles, Len),
	% Equivale a: if(Len == 0): {R = 1000} else {R = Len}
	(   Len = 0 -> R = 1000; R = Len).
 

possible_move(NumCols, L, (Xpos, Ypos)) :-
	% Compruebo los límites del tablero
	Xpos >= 0, Ypos >= 0, Xpos < NumCols, Ypos < NumCols,
	Pos is Xpos * NumCols + Ypos,
	% Obtengo el valor V, que es L[Pos]
	nth0(Pos, L, V),
	% Compruebo si V sí es una variable
	var(V).
 
 
display(_, _, [],_).
display(N, N, L, I) :-
	nl,
	I1 is I + 1,
	display(N, 0, L, I1).
 
% I es la fila, J la columna
display(N, J, [H | T], I) :-
	writef('%3r', [H]),
	J1 is J + 1,
	display(N, J1, T, I).
 