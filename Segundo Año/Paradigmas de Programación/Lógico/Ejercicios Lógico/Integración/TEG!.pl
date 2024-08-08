/* distintos paises */
paisContinente(americaDelSur, argentina).
paisContinente(americaDelSur, bolivia).
paisContinente(americaDelSur, brasil).
paisContinente(americaDelSur, chile).
paisContinente(americaDelSur, ecuador).
paisContinente(europa, alemania).
paisContinente(europa, espania).
paisContinente(europa, francia).
paisContinente(europa, inglaterra).
paisContinente(asia, aral).
paisContinente(asia, china).
paisContinente(asia, gobi).
paisContinente(asia, india).
paisContinente(asia, iran).

/*países importantes*/
paisImportante(argentina).
paisImportante(kamchatka).
paisImportante(alemania).

/*países limítrofes*/
limitrofes([argentina,brasil]).
limitrofes([bolivia,brasil]).
limitrofes([bolivia,argentina]).
limitrofes([argentina,chile]).
limitrofes([espania,francia]).
limitrofes([alemania,francia]).
limitrofes([nepal,india]).
limitrofes([china,india]).
limitrofes([nepal,china]).
limitrofes([afganistan,china]).
limitrofes([iran,afganistan]).

/*distribución en el tablero */
ocupa(argentina, azul, 4).
ocupa(bolivia, rojo, 1).
ocupa(brasil, verde, 4).
ocupa(chile, negro, 3).
ocupa(ecuador, rojo, 2).
ocupa(alemania, azul, 3).
ocupa(espania, azul, 1).
ocupa(francia, azul, 1).
ocupa(inglaterra, azul, 2). 
ocupa(aral, negro, 2).
ocupa(china, verde, 1).
ocupa(gobi, verde, 2).
ocupa(india, rojo, 3).
ocupa(iran, verde, 1).

/*continentes*/
continente(americaDelSur).
continente(europa).
continente(asia).

/*objetivos*/
objetivo(rojo, ocuparContinente(asia)).
objetivo(azul, ocuparPaises([argentina, bolivia, francia, inglaterra, china])).
objetivo(verde, destruirJugador(rojo)).
objetivo(negro, ocuparContinente(europa)).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
estaEnContinente(Jugador, Continente) :-
    ocupaPais(Pais, Jugador),
    paisContinente(Continente, Pais).

ocupaPais(Pais, Jugador) :-
    ocupa(Pais, Jugador, _).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
cantidadPaises(Jugador, Cantidad) :-
    jugador(Jugador),
    findall(Pais, ocupaPais(Pais, Jugador), Paises),
    length(Paises, Cantidad).

jugador(Jugador) :-
    ocupa(_, Jugador, _).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
ocupaContinente(Jugador, Continente) :-
    continente(Continente),
    jugador(Jugador),
    forall(paisContinente(Continente, Pais), ocupaPais(Pais, Jugador)).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
leFaltaMucho(Jugador, Continente) :-
    jugador(Jugador),
    continente(Continente),
    findall(Pais, noOcupa(Pais, Jugador, Continente), PaisesNoOcupados),
    length(PaisesNoOcupados, Cantidad),
    Cantidad > 2.

noOcupa(Pais, Jugador, Continente) :-
    jugador(Jugador),
    paisContinente(Continente, Pais),
    not(ocupaPais(Pais, Jugador)).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
sonLimitrofes(Pais1, Pais2) :-
    limitrofes([Pais1, Pais2]).

sonLimitrofes(Pais1, Pais2) :-
    limitrofes([Pais2, Pais1]).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
esGroso(Jugador) :-
    jugador(Jugador),
    forall(paisImportante(Pais), ocupaPais(Pais, Jugador)).

esGroso(Jugador) :-
    cantidadPaises(Jugador, CantidadOcupada),
    CantidadOcupada > 10.

esGroso(Jugador) :-
    cantidadEjercitos(Jugador, Cantidad),
    Cantidad > 50.

cantidadEjercitos(Jugador, Cantidad) :-
    jugador(Jugador),
    findall(Ejercito, ocupa(_, Jugador, Ejercito), Ejercitos),
    sumlist(Ejercitos, Cantidad).

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
estaEnElHorno(Pais) :-
    ocupaPais(Pais, Jugador),
    jugador(OtroJugador),
    Jugador \= OtroJugador,
    forall(sonLimitrofes(Pais, PaisLimitrofe), ocupaPais(PaisLimitrofe, OtroJugador)).

%%%%%%%%%%%%
% Punto 08 %
%%%%%%%%%%%%
esCaotico(Continente) :-
    continente(Continente),
    findall(Jugador, estaEnContinente(Jugador, Continente), Jugadores),
    length(Jugadores, CantidadJugadores),
    CantidadJugadores > 3.

%%%%%%%%%%%%
% Punto 09 %
%%%%%%%%%%%%
capoCannoniere(Jugador) :-

%%%%%%%%%%%%
% Punto 10 %
%%%%%%%%%%%%
ganadooor(Jugador) :-
    objetivo(Jugador, Objetivo),
    logroObjetivo(Jugador, Objetivo).

logroObjetivo(Jugador, ocuparContinente(Continente)) :-
    ocupaContinente(Jugador, Continente).

logroObjetivo(Jugador, ocuparPaises(Paises)) :-
    jugador(Jugador),
    paises(Paises),
    forall(member(Pais, Paises), ocupaPais(Pais, Jugador)).

logroObjetivo(Jugador, destruirJugador(OtroJugador)) :-
    cantidadEjercitos(OtroJugador, 0).

paises(Paises) :-
    forall(member(Pais, Paises), pais(Pais)).

pais(Pais) :-
    paisContinente(_, Pais).