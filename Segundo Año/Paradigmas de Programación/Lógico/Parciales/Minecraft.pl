%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
% jugador(Nombre, Items, Hambre).
jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

% lugar(Bioma, Jugadores, Oscuridad).
lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

% comestible(Comida).
comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

% item(Item, Composición).
item(horno, [itemSimple(piedra, 8)]).
item(placaDeMadera, [itemSimple(madera, 1)]).
item(palo, [itemCompuesto(placaDeMadera)]).
item(antorcha, [itemCompuesto(palo), itemSimple(carbon, 1)]).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% a.
tieneItem(Jugador, Item) :-
    jugador(Jugador, Items, _),
    member(Item, Items).

% b.
sePreocupaPorSuSalud(Jugador) :-
    tieneItem(Jugador, Item1),
    tieneItem(Jugador, Item2),
    Item1 \= Item2,
    comestible(Item1),
    comestible(Item2).

% c.
cantidadDeItem(Jugador, Item, Cantidad) :-
    player(Jugador),
    item(Item),
    findall(Item, tieneItem(Jugador, Item), Items),
    length(Items, Cantidad).

item(Item) :-
    tieneItem(_, Item).

player(Jugador) :-
    jugador(Jugador, _, _).

% d.
tieneMasDe(Jugador, Item) :-
    cantidadDeItem(Jugador, Item, CantidadMayor),
    forall(cantidadDeItem(_, Item, CantidadMenor), CantidadMayor >= CantidadMenor).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
% a.
hayMonstruos(Lugar) :-
    lugar(Lugar, _, Oscuridad),
    Oscuridad > 6.

% b.
correPeligro(Jugador) :-
    lugar(Lugar, Jugador, _),
    hayMonstruos(Lugar).
correPeligro(Jugador) :-
    estaHambriento(Jugador),
    noTieneItemsComestibles(Jugador).

estaHambriento(Jugador) :-
    jugador(Jugador, _, Hambre),
    Hambre < 4.

noTieneItemsComestibles(Jugador) :-
    player(Jugador),
    forall(tieneItem(Jugador, Item), noEsComestible(Item)).

noEsComestible(Item) :-
    item(Item),
    not(comestible(Item)).

% c.
nivelPeligrosidad(Lugar, Peligro) :-
    lugar(Lugar, _, _),
    not(hayMonstruos(Lugar)),
    cantidadDeHambrientos(Cantidad),
    poblacionTotal(Lugar, Poblacion),
    Peligro is (Cantidad / Poblacion) * 100.
nivelPeligrosidad(Lugar, 100) :-
    hayMonstruos(Lugar).
nivelPeligrosidad(Lugar, Peligro) :-
    lugar(Lugar, [], Oscuridad),
    Peligro is Oscuridad * 10.

cantidadDeHambrientos(Cantidad) :-
    findall(Jugador, estaHambriento(Jugador), JugadoresHambrientos),
    length(JugadoresHambrientos, Cantidad).

poblacionTotal(Lugar, Poblacion) :-
    lugar(Lugar, Habitantes, _),
    length(Habitantes, Poblacion).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
puedeConstruir(Jugador, Item) :-
    item(Item, Composicion),
    puedeFabricar(Jugador, Composicion).

puedeFabricar(Jugador, Composicion) :-
    player(Jugador),
    forall(member(Item, Composicion), tieneItem2(Jugador, Item)).

tieneItem2(Jugador, itemSimple(Item, Cantidad)) :-
    cantidadDeItem(Jugador, Item, CantidadDisponible),
    CantidadDisponible >= Cantidad.
tieneItem2(Jugador, itemCompuesto(Item)) :-
    tieneItem2(Jugador, Item).
tieneItem2(Jugador, itemCompuesto(Item)) :-
    puedeConstruir(Jugador, Item).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
% a.
/*
Responde false dado que no hay una cláusula de lugar definida para el átomo desierto, por ende, por
principio de universo cerrado, la respuesta es false.
*/

% b.
/*
La posibilidad de obtener múltiples respuestas para una misma consulta.
Consultas variables e inversibilidad.
Backtracking automático.
*/