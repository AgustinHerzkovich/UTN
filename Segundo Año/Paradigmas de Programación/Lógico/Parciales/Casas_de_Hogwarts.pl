% Parte 1 %
% mago(Nombre, StatusDeSangre, Características).
mago(harry, mestiza, [coraje, amistad, orgullo, inteligencia]).
mago(draco, pura, [inteligencia, orgullo]).
mago(hermione, impura, [inteligencia, orgullo, responsabilidad]).

% odia(Mago, Casa).
odia(harry, slytherin).
odia(draco, hufflepuff).

% criterioSeleccion(Casa, Característica).
criterioSeleccion(gryffindor, coraje).
criterioSeleccion(slytherin, orgullo).
criterioSeleccion(slytherin, inteligencia).
criterioSeleccion(ravenclaw, inteligencia).
criterioSeleccion(ravenclaw, responsabilidad).
criterioSeleccion(hufflepuff, amistad).

% casa(Casa).
casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
permite(Casa, Mago) :-
    casa(Casa),
    not(casa(slytherin)),
    nombreMago(Mago).
permite(slytherin, Mago) :-
    noTieneSangreImpura(Mago).

nombreMago(Mago) :-
    mago(Mago, _, _).

noTieneSangreImpura(Mago) :-
    sangre(Mago, Sangre),
    Sangre \= impura.

sangre(Mago, Sangre) :-
    mago(Mago, Sangre, _).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
apropiado(Mago, Casa) :-
    nombreMago(Mago),
    casa(Casa),
    forall(criterioSeleccion(Casa, Caracteristica), posee(Mago, Caracteristica)).

posee(Mago, Caracteristica) :-
    caracteristicas(Mago, Caracteristicas),
    member(Caracteristica, Caracteristicas).

caracteristicas(Mago, Caracteristicas) :-
    mago(Mago, _, Caracteristicas).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
puedeQuedar(Mago, Casa) :-
    nombreMago(Mago),
    casa(Casa),
    apropiado(Mago, Casa),
    permite(Casa, Mago),
    not(odia(Mago, Casa)).
puedeQuedar(hermione, gryffindor).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
cadenaDeAmistades(Magos) :-
    forall(member(Mago, Magos), amistoso(Mago)),
    cadenaMagica(Magos).

amistoso(Mago) :-
    posee(Mago, amistad).

cadenaMagica([Mago1, Mago2 | Magos]) :-
    puedeQuedar(Mago1, Casa),
    puedeQuedar(Mago2, Casa),
    cadenaMagica([Mago2, Magos]).

% Parte 2 %
hizo(harry, fueraDeCamaDeNoche).
hizo(hermione, irA(tercerPiso)).
hizo(hermino, irA(seccionRestringidaBiblioteca)).
hizo(harry, irA(bosque)).
hizo(harry, irA(tercerPiso)).
hizo(draco, irA(mazmorras)).
hizo(ron, ganarAjedrezMagico).
hizo(hermione, salvarAmigos).
hizo(harry, ganarAVoldemort).
% responderEnClase(Pregunta, Dificultad, Profesor).
hizo(hermione, responderEnClase(dondeSeEncuentraUnBezoar, 20, snape)). %Agregado por Punto 04
hizo(hermione, responderEnClase(comoHacerLevitarUnaPluma, 25, flitwick)). %Agregado por Punto 04

puntos(fueraDeCamaDeNoche, -50).
puntos(irA(bosque), -50).
puntos(irA(seccionRestringidaBiblioteca), -10).
puntos(irA(tercerPiso), -75).
puntos(ganarAjedrezMagico, 50).
puntos(salvarAmigos, 50).
puntos(ganarAVoldemort, 60).
puntos(responderEnClase(_, Dificultad, Profesor), Dificultad) :- % Agregado por Punto 04
    Profesor \= snape.
puntos(responderEnClase(_, Dificultad, snape), Puntos) :- % Agregado por Punto 04
    Puntos is Dificultad / 2.

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% a.
buenAlumno(Mago) :-
    hizo(Mago, _),
    forall(hizo(Mago, Accion), buenaAccion(Accion)).

buenaAccion(Accion) :-
    puntos(Accion, Puntos),
    Puntos >= 0.

% b.
recurrente(Accion) :-
    hizo(Mago1, Accion),
    hizo(Mago2, Accion),
    Mago1 \= Mago2.

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
puntajeTotal(Casa, Puntaje) :-
    findall(PuntosMiembro, puntosDeMiembro(Casa, PuntosMiembro), PuntosCasa),
    sumlist(PuntosCasa, Puntaje).

puntosDeMiembro(Casa, Puntos) :-
    esDe(Mago, Casa),
    puntosObtenidos(Mago, Puntos).

puntosObtenidos(Mago, Puntos) :-
    findall(PuntosAccion, puntosDeAccion(Mago, PuntosAccion), Puntaje),
    sumlist(Puntaje, Puntos).

puntosDeAccion(Mago, Puntos) :-
    hizo(Mago, Accion),
    puntos(Accion, Puntos).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
ganadora(Casa) :-
    casa(Casa),
    forall(casaDistintaDe(Casa, OtraCasa), tieneMasPuntos(Casa, OtraCasa)).

casaDistintaDe(Casa, OtraCasa) :-
    casa(Casa),
    casa(OtraCasa),
    Casa \= OtraCasa.

tieneMasPuntos(Casa, OtraCasa) :-
    puntajeTotal(Casa, PuntajeMayor),
    puntajeTotal(OtraCasa, PuntajeMenor),
    PuntajeMayor > PuntajeMenor.

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
% AGREGADO.