min_lista(L,X) :- X = L1, [L1|_] = L.
min_lista(L,X) :- [_|L2] = L, X = min_lista(L2,X).