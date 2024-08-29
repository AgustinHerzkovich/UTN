%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
% Relaciona al dueño con el nombre del juguete y la cantidad de años que lo ha tenido
duenio(andy, woody, 8).
duenio(sam, jessie, 3).

% Relaciona al juguete con su nombre
% los juguetes son de la forma:
% deTrapo(tematica)
% deAccion(tematica, partes)
% miniFiguras(tematica, cantidadDeFiguras)
% caraDePapa(partes)
juguete(woody, deTrapo(vaquero)).
juguete(jessie, deTrapo(vaquero))
juguete(buzz, deAccion(espacial, [original(casco)])).
juguete(soldados, miniFiguras(soldado, 60)).
juguete(monitosEnBarril, miniFiguras(mono, 50)).
juguete(seniorCaraDePapa,caraDePapa([ original(pieIzquierdo), original(pieDerecho), repuesto(nariz) ])).

% Dice si un juguete es raro
esRaro(deAccion(stacyMalibu, 1, [sombrero])).

% Dice si una persona es coleccionista
esColeccionista(sam).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% a.
tematica(deTrapo(Tematica), Tematica).
tematica(deAccion(Tematica, _), Tematica).
tematica(miniFiguras(Tematica, _), Tematica).
tematica(caraDePapa(_), caraDePapa).

% b.
esDePlastico(miniFiguras(_, _)).
esDePlastico(caraDePapa(_)).

% c.
esDeColeccion(Juguete) :-
    caraDePapaOAccion(Juguete),
    esRaro(Juguete).
esDeColeccion(deTrapo(_)).

caraDePapaOAccion(caraDePapa(_)).
caraDePapaOAccion(deAccion(_, _)). 

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
amigoFiel(Duenio, NombreJuguete) :-
    juguete(NombreJuguete, Juguete),
    not(esDePlastico(Juguete)),
    loTieneHaceMasTiempo(Duenio, NombreJugueteJuguete).

loTieneHaceMasTiempo(Duenio, Juguete) :-
    duenio(Duenio, Juguete, Anios)
    forall(duenio(Duenio, OtroJuguete, OtrosAnios), Anios >= OtrosAnios).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
superValioso(NombreJuguete) :-
    juguete(NombreJuguete, Juguete),
    esDeColeccion(Juguete),
    todasSusPiezasOriginales(Juguete),
    noEsColeccionado(NombreJuguete).

todasSusPiezasOriginales(Juguete) :-
    juguete(_, Juguete),
    forall(pieza(Juguete, Pieza), esOriginal(Pieza)).

pieza(deAccion(_, Piezas), Pieza) :-
    member(Pieza, Piezas).
pieza(caraDePapa(_, Piezas), Pieza) :-
    member(Pieza, Piezas).

esOriginal(original(_)).

noEsColeccionado(NombreJuguete) :-
    duenio(Duenio, NombreJuguete, _),
    not(esColeccionista(Duenio)).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
duoDinamico(Duenio, Nombre1, Nombre2) :-
    duenio(Duenio, Nombre1, _),
    duenio(Duenio, Nombre2, _),
    hacenBuenaPareja(Nombre1, Nombre2).

hacenBuenaPareja(NombreJuguete1, NombreJuguete2) :-
    juguete(NombreJuguete1, Juguete1),
    juguete(NombreJuguete2, Juguete2),
    mismaTematica(Juguete1, Juguete2).
hacenBuenaPareja(woody, buzz).
hacenBuenaPareja(buzz, woody).

mismaTematica(Juguete1, Juguete2) :-
    tematica(Juguete1, Tematica),
    tematica(Juguete2, Tematica).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
felicidad(Duenio, Felicidad) :-
    findall(FelicidadOtorgada, felicidadOtorgada(Duenio, _, FelicidadOtorgada), Felicidades),
    sumlist(Felicidades, Felicidad).

felicidadOtorgada(_, miniFiguras(_, Cantidad), Felicidad) :-
    Felicidad is 20 * Cantidad.
felicidadOtorgada(_, caraDePapa(Piezas), Felicidad) :-
    felicidadSegunPiezas(Piezas, Felicidad).
felicidadOtorgada(_, deTrapo(_), 100).
felicidadOtorgada(Duenio, Juguete, 120) :-
    esDeAccion(Juguete),
    felicidadSegunCalidad(Duenio, Juguete, Felicidad).

felicidadSegunPiezas(Piezas, Felicidad) :-
    findall(Puntos, puntosPorPieza(Piezas, Puntos), PuntosTotales),
    sumlist(PuntosTotales, Felicidad).

puntosPorPieza(Piezas, Puntos) :-
    member(Pieza, Puntos),
    puntosPieza(Pieza, Puntos).

puntosPieza(original(_), 5).
puntosPieza(repuesto(_), 8).

esDeAccion(deAccion(_, _)).

felicidadSegunCalidad(Duenio, Juguete, 120) :-
    esDeColeccion(Juguete),
    esColeccionista(Duenio).
felicidadSegunCalidad(Duenio, Juguete, Felicidad) :-
    juguete(_, Juguete),
    duenio(Duenio, _, _),
    not(esDeColeccion(Juguete)),
    not(esColeccionista(Duenio)),
    felicidadOtorgada(_, deTrapo(_), Felicidad).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
puedeJugarCon(Alguien, NombreJuguete) :-
    duenio(Alguien, NombreJuguete, _).
puedeJugarCon(Alguien, NombreJuguete) :-
    puedeJugarCon(Otro, NombreJuguete),
    puedePrestarle(Otro, Alguien).

puedePrestarle(Alguien1, Alguien2) :-
    tieneMasJuguetes(Alguien1, Alguien2).

tieneMasJuguetes(Alguien1, Alguien2) :-
    cantidadJuguetes(Alguien1, Cantidad1),
    cantidadJuguetes(Alguien2, Cantidad2),
    Cantidad1 > Cantidad2.

cantidadJuguetes(Persona, Cantidad) :-
    duenio(Persona, _, _),
    findall(Juguete, duenio(Persona, Juguete, _), Juguetes),
    length(Juguetes, Cantidad).

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
podriaDonar(Duenio, Juguetes, Felicidad) :-
    felicidadQueGeneran(Duenio, Juguetes, FelicidadMenor),
    FelicidadMenor < Felicidad.

felicidadQueGeneran(Duenio, Juguetes, Felicidad) :-
    duenio(Duenio, _, _),
    findall(Puntos, (member(Juguete, Juguetes), felicidadOtorgada(Duenio, Juguete, Puntos)), PuntosFelicidad),
    sumlist(PuntosFelicidad, Felicidad).

%%%%%%%%%%%%
% Punto 08 %
%%%%%%%%%%%%
% Punto 01, Punto 03 para piezas y originalidad, Punto 05 felicidadOtorgada, puntosPieza y esDeAccion.