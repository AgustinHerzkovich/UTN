%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
personaje(thundercat(leonO, 5)). %nombre, fuerza
personaje(thundercat(jaga, 0)). %¡es un espíritu!
personaje(thundercat(panthro, 4)).
personaje(thundercat(cheetara, 3)).
personaje(thundercat(tigro, 3)).
personaje(thundercat(grune, 4)).
personaje(mutante(reptilio, 4)). %nombre, fuerza
personaje(mutante(chacalo, 2)).
personaje(mutante(buitro, 2)).
personaje(mutante(mandrilok, 3)).
personaje(lunatack(luna)).
personaje(lunatack(chilla)).
personaje(momia(mummRa)).
personaje(momia(mummRana)).

traidor(grune).
traidor(chacalo).

lider(thundercat, leonO). %facción, líder
lider(mutante, reptilio).
lider(lunatack, luna).

guia(jaga).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
faccionPersonaje(Personaje, thundercat) :-
    personaje(thundercat(Personaje, _)).
faccionPersonaje(Personaje, mutante) :-
    personaje(mutante(Personaje, _)).
faccionPersonaje(Personaje, lunatack) :-
    personaje(lunatack(Personaje)).
faccionPersonaje(Personaje, momia) :-
    personaje(momia(Personaje)).

% a.
viveEn(Personaje, cubilFelino) :-
    faccionPersonaje(Personaje, thundercat),
    not(traidor(Personaje)).

% b.
viveEn(Personaje, madriguera) :-
    faccionPersonaje(Personaje, mutante).

% c.
viveEn(Personaje, piramide) :-
    faccionPersonaje(Personaje, momia).

% d.
% No se escribe cláusula por principio de universo cerrado.

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
faccion(Faccion) :-
    lider(Faccion, _).
faccion(FaccionMomia) :-
    personaje(momia(FaccionMomia)).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
caracteristicas(Personaje, Faccion, Fuerza) :-
    faccionPersonaje(Personaje, Faccion),
    fuerza(Personaje, Fuerza).

fuerza(Personaje, Fuerza) :-
    personaje(thundercat(Personaje, Fuerza)).
fuerza(Personaje, Fuerza) :-
    personaje(mutante(Personaje, Fuerza)).
fuerza(Personaje, 3) :-
    faccionPersonaje(Personaje, lunatack).
fuerza(Personaje, 8) :-
    faccionPersonaje(Personaje, momia).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
esArmonico(Personajes) :-
    Personajes \= [],
    personajes(Personajes),
    traidoresOMismaFaccion(Personajes).

personajes(Personajes) :-
    maplist(faccionPersonajeInversible, Personajes).

faccionPersonajeInversible(Personaje) :-
    faccionPersonaje(Personaje, _).

traidoresOMismaFaccion(Personajes) :-
    mismaFaccion(Personajes),
    maplist(notTraidor, Personajes).
traidoresOMismaFaccion(Personajes) :-
    maplist(traidor, Personajes).

mismaFaccion(Personajes) :-
    maplist(mismaFaccionPersonaje(_), Personajes).

mismaFaccionPersonaje(Personaje1, Personaje2) :-
    faccionPersonaje(Personaje1, Faccion),
    faccionPersonaje(Personaje2, Faccion).

notTraidor(Personaje) :-
    \+ traidor(Personaje).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
puedeGuiarA(Guia, Personaje) :-
    mismaFaccionPersonaje(Guia, Personaje),
    guiasVsLiderVsFuerte(Guia, Personaje).

guiasVsLiderVsFuerte(Guia, Lider) :-
    guia(Guia),
    lider(_, Lider).
guiasVsLiderVsFuerte(Fuerte, Debil) :-
    not(guia(Debil)),
    masFuerte(Fuerte, Debil).
guiasVsLiderVsFuerte(mummRa, Personaje) :-
    esMalo(Personaje).

esMalo(Personaje) :-
    faccionPersonaje(Personaje, Faccion),
    faccionMala(Faccion).
esMalo(Personaje) :-
    traidor(Personaje).
esMalo(mummRa).

faccionMala(mutante).
faccionMala(lunatack).

masFuerte(Fuerte, Debil) :-
    faccionPersonajeInversible(Fuerte),
    faccionPersonajeInversible(Debil),
    fuerza(Fuerte, MayorFuerza),
    fuerza(Debil, MenorFuerza),
    MayorFuerza > MenorFuerza.

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
fuerzaGuiada(Personaje, FuerzaTotal) :-
    fuerza(Personaje, FuerzaUnitaria),
    findall(Fuerza, fuerzaDeGuiado(Personaje, Fuerza), Fuerzas),
    sumlist(Fuerzas, SubtotalFuerzas),
    append(SubtotalFuerzas, FuerzaUnitaria, FuerzaTotal).

fuerzaDeGuiado(Personaje, Fuerza) :-
    puedeGuiarA(Personaje, Guiado),
    fuerza(Guiado, Fuerza).

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
nivelDeGuia(Personaje, 1) :-
    puedeGuiarA(Personaje, _).
nivelDeGuia(Personaje, Nivel) :-
    puedeGuiarA(Personaje, Alguien),
    nivelDeGuia(Alguien, Subnivel),
    Nivel is Subnivel + 1.

%%%%%%%%%%%%
% Punto 08 %
%%%%%%%%%%%%
seArmoLaHecatombe(Personajes) :-
    findall(Faccion, (member(Personaje, Personajes), faccionPersonaje(Personaje , Faccion)), Facciones),
    sinRepetidos(Facciones, Personajes),
    length(Personajes, Cantidad),
    Cantidad >= 3.