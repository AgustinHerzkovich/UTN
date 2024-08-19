% jugadores conocidos
jugador(maradona).
jugador(chamot).
jugador(balbo).
jugador(caniggia).
jugador(passarella).
jugador(pedemonti).
jugador(basualdo).

% relaciona la máxima cantidad de un producto que 1 jugador puede ingerir
maximo(cocacola, 3). 
maximo(gatoreit, 1).
maximo(naranju, 5).

% relaciona las sustancias que tiene un compuesto
composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).

% sustancias prohibidas por la asociación
sustanciaProhibida(efedrina). 
sustanciaProhibida(cocaina).

% relaciona lo que toma cada jugador
tomo(maradona, sustancia(efedrina)).
tomo(maradona, compuesto(cafeVeloz)).
tomo(caniggia, producto(cocacola, 2)).
tomo(chamot, compuesto(cafeVeloz)).
tomo(balbo, producto(gatoreit, 2)).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% a.
tomo(passarella, Bebida) :-
    not(tomo(maradona, Bebida)).

% b.
tomi(pedemonti, Bebida) :-
    tomo(maradona, Bebida),
    not(tomo(chamot, Bebida)).

% c.
% no se agrega cláusula y con eso es suficiente.

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
puedeSerSuspendido(Jugador) :-
    jugador(Jugador),
    hizoAlgoProhibido(Jugador).

hizoAlgoProhibido(Jugador) :-
    tomoSustanciaProhibida(Jugador).
hizoAlgoProhibido(Jugador) :-
    tomoCompuestoProhibido(Jugador).
hizoAlgoProhibido(Jugador) :-
    tomoCantidadExcesiva(Jugador).

tomoSustanciaProhibida(Jugador) :-
    tomo(Jugador, sustancia(NombreSustancia)),
    sustanciaProhibida(NombreSustancia).

tomoCompuestoProhibido(Jugador) :-
    tomo(Jugador, compuesto(NombreCompuesto)),
    esProhibido(NombreCompuesto).

tomoCantidadExcesiva(Jugador) :-
    tomo(Jugador, producto(Producto, CantidadConsumida)),
    maximo(Producto, CantidadPermitida),
    CantidadConsumida > CantidadPermitida.

esProhibido(Compuesto) :-
    composicion(Compuesto, Sustancias),
    contieneSustanciaProhibida(Sustancias).

contieneSustanciaProhibida(Sustancias) :-
    member(Sustancia, Sustancias),
    sustanciaProhibida(Sustancia).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
amigo(maradona, caniggia).
amigo(caniggia, balbo).
amigo(balbo, chamot).
amigo(balbo, pedemonti).

malaInfluencia(Jugador1, Jugador2) :-
    puedeSerSuspendido(Jugador1),
    puedeSerSuspendido(Jugador2),
    seConocen(Jugador1, Jugador2).

seConocen(Jugador1, Jugador2) :-
    conoce(Jugador1, Jugador2),
    conoce(Jugador2, Jugador1).

conoce(Jugador1, Jugador2) :-
    amigo(Jugador1, Jugador2).
conoce(Jugador1, Jugador2) :-
    amigo(Jugador1, Amigo),
    conoce(Amigo, Jugador2).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%