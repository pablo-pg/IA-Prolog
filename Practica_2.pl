% Ejercicio 1: pertenece/3

% Realizar un predicado 'pertenece/3' que detecte si un número real (primer
% argumento) pertenece al intervalo en la recta real determinado por el
% límite inferior, segundo argumento, y el límite superior, tercer argumento.
% Por ejemplo, pertenece(5.5, 1.3, 7.2) habría de devolver true.

pertenece(X, Y, Z) :- X =< Z, X >= Y.


% Ejercicio 2: generado_int/3

% Realizar un predicado 'generado_int/3' que genere en sucesivas resatisfacciones
% los enteros, primer argumento, que estén dentro de un intervalo determinado por
% el límite inferior, entero del segundo argumento, y el límite superior, entero
% del tercer argumento. Por ejemplo, generado_int(X, 2, 5) habría de devolver X=2;
% X=3; X=4; X=5.

generado_int(A, A, B).
generado_int(X, Y, Z) :- generado_int(W, Y, Z), X is W + 1, X >= Y, X =< Z.


% Ejercicio 3: mcm/3 y mcd/3

% Realizar los predicados 'mcm/3' y 'mcd/3' que devuelva en el primer argumento
% el mínimo común múltiplo y el máximo común divisor respectivamente de los dos
% últimos argumentos. Por ejemplo, mcm(X, 2, 5) habría de devolver X=10.

% mcd

mcd(X,X,X).
mcd(X,Y,Z) :- Y < Z, W is Z - Y, mcd(X,Y,W).
mcd(X,Y,Z) :- Y > Z, mcd(X, Z, Y).

%mcm

mcm(A, B, C) :- mcd(X, B, C), A is (B * C) / X.


% Ejercicio 4: Día de la semana según Lewis Caroll

% Realizar un programa prolog para el cálculo del día de la semana para fechas
% modernas mediante el método de Lewis Carroll. Ha de generarse un predicado
% 'dia_semana/4' cuyos tres primeros argumentos sean números con el día, mes y
% año de una fecha, y el último argumento debe instanciarse al átomo del día de
% la semana, uno entre lunes, martes, miercoles, jueves, viernes, sabado,
% domingo, correspondiente a dicha fecha, por ejemplo: * ? - dia_semana(31, 12, 2021, X) * X = viernes

