amigo(juan, alberto).
amigo(juan, pedro).
amigo(pedro,mirta).
amigo(alberto, tomas).
amigo(tomas,mirta).

enemigo(mirta,ana).
enemigo(juan,nestor).
enemigo(juan,mirta).

mesaArmada(navidad2010,mesa(1,[juan,mirta,ana,nestor])).
mesaArmada(navidad2010,mesa(5,[andres,german,ludmila,elias])).
mesaArmada(navidad2010,mesa(8,[nestor,pedro])).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% estaSentadaEn(Persona, Mesa).
estaSentadaEn(Persona, Mesa) :-
    mesaArmada(_, Mesa),
    perteneceAMesa(Persona, Mesa).

perteneceAMesa(Persona, mesa(_, Personas)) :-
    member(Persona, Personas).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
% sePuedeSentar(Persona, Mesa).
sePuedeSentar(Persona, Mesa) :-
    hayAlgunAmigo(Persona, Mesa),
    not(hayAlgunEnemigo(Persona, Mesa)).

hayAlgunAmigo(Persona, mesa(_, Personas)) :-
    member(Amigo, Personas),
    amigo(Persona, Amigo).

hayAlgunEnemigo(Persona, mesa(_, Personas)) :-
    member(Enemigo, Personas),
    enemigo(Persona, Enemigo).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
% mesaDeCumpleaniero(Cumpleaniero, Mesa).
mesaDeCumpleaniero(Cumpleaniero, mesa(1, AmigosYCumpleaniero)) :-
    findall(Amigo, amigo(Cumpleaniero, Amigo), Amigos),
    append([Cumpleaniero], Amigos, AmigosYCumpleaniero).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
% incompatible(Persona1, Persona2).
incompatible(Persona1, Persona2) :-
    amigo(Persona1, PersonaEnComun),
    enemigo(Persona2, PersonaEnComun).
incompatible(Persona1, Persona2) :-
    amigo(Persona2, PersonaEnComun),
    enemigo(Persona1, PersonaEnComun).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
% laPeorOpcion(Perona, Mesa).
laPeorOpcion(Persona, Mesa) :-
    forall(estaSentadaEn(Integrante, Mesa), enemigo(Persona, Integrante)).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
% mesasPlanificadas(Fiesta, [Mesa]).
mesasPlanificadas(Fiesta, Mesas) :-
    mesaArmada(Fiesta, _),
    findall(Mesa, mesaArmada(Fiesta, Mesa), Mesas).

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
% esViable([Mesa]).
esViable(Mesas) :-
    numerosCorrectos(Mesas),
    cantidadDePersonasPorMesa(Mesas, 4),
    mesasSinEnemigos(Mesas).

numerosCorrectos([mesa(1, _)]).
numerosCorrectos(Mesas) :-
    length(Mesas, CantidadDeMesas),
    forall(member(Mesa, Mesas), (numeroDeMesa(Mesa, Numero), Numero =< CantidadDeMesas)).

numeroDeMesa(mesa(Numero, _), Numero).

cantidadDePersonasPorMesa(Mesas, Cantidad) :-
    forall(member(Mesa, Mesas), cantidadDePersonas(Mesa, Cantidad)).

cantidadDePersonas(mesa(_, Personas), Cantidad) :-
    length(Personas, Cantidad).

mesasSinEnemigos(Mesas) :-
    forall(member(Mesa, Mesas), sinEnemigos(Mesa)).

sinEnemigos(mesa(_, Personas)) :-
    forall(par(Persona1, Persona2, Personas), not(sonEnemigos(Persona1, Persona2))).

par(Persona1, Persona2, Personas) :-
    member(Persona1, Personas),
    member(Persona2, Personas).

sonEnemigos(Persona1, Persona2) :-
    enemigo(Persona1, Persona2).
sonEnemigos(Persona1, Persona2) :-
    enemigo(Persona2, Persona1).