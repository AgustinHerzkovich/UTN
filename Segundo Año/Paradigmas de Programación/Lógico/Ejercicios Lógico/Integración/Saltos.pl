puntajes(hernan, [3,5,8,6,9]).
puntajes(julio, [9,7,3,9,10,2]).
puntajes(ruben, [3,5,3,8,3]).
puntajes(roque, [7,10,10]).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
puntaje(Competidor, Salto, Puntaje) :-
    puntajes(Competidor, Saltos),
    nth1(Salto, Saltos, Puntaje).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
descalificado(Competidor) :-
    puntajes(Competidor, Saltos),
    length(Saltos, Cantidad),
    Cantidad > 5.

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
finalista(Competidor) :-
    puntajes(Competidor, Saltos),
    sumlist(Saltos, Total),
    Total >= 28.

finalista(Competidor) :-
    puntajes(Competidor, Saltos),
    findall(Salto, saltoAlto(Salto, Saltos), SaltosAltos),
    length(SaltosAltos, Cantidad),
    Cantidad >= 2.

saltoAlto(Salto, Saltos) :-
    member(Salto, Saltos),
    Salto >= 8.