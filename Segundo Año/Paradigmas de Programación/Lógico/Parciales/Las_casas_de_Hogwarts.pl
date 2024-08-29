%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
mago(harry, mestiza, [coraje, amistad, orgullo, inteligencia]).
mago(ron, pura, [amistad, diversion, coraje]).
mago(hermione, impura, [inteligencia, coraje, responsabilidad, amistad, orgullo]).
mago(hannahAbbott, mestiza, [amistad, diversion]).
mago(draco, pura, [inteligencia, orgullo]).
mago(lunaLovegood, mestiza, [inteligencia, responsabilidad, amistad, coraje]).

odia(harry,slytherin).
odia(draco,hufflepuff).

casa(gryffindor).
casa(hufflepuff).
casa(ravenclaw).
casa(slytherin).

caracteriza(gryffindor,amistad).
caracteriza(gryffindor,coraje).
caracteriza(slytherin,orgullo).
caracteriza(slytherin,inteligencia).
caracteriza(ravenclaw,inteligencia).
caracteriza(ravenclaw,responsabilidad).
caracteriza(hufflepuff,amistad).
caracteriza(hufflepuff,diversion).

lugarProhibido(bosque,50).
lugarProhibido(seccionRestringida,10).
lugarProhibido(tercerPiso,75).

alumnoFavorito(flitwick, hermione).
alumnoFavorito(snape, draco).
alumnoOdiado(snape, harry).

hizo(ron, buenaAccion(jugarAlAjedrez, 50)).
hizo(harry, fueraDeCama).
hizo(hermione, irA(tercerPiso)).
hizo(hermione, responder("Donde se encuentra un Bezoar", 15, snape)).
hizo(hermione, responder("Wingardium Leviosa", 25, flitwick)).
hizo(ron, irA(bosque)).
hizo(draco, irA(mazmorras)).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
permiteEntrar(slytherin, Mago) :-
    sangreImpura(Mago).
permiteEntrar(Casa, Mago) :-
    casa(Casa),
    magoX(Mago).

sangreImpura(Mago) :-
    mago(Mago, impura, _).

magoX(Mago) :-
    mago(Mago, _, _).
%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
tieneCaracter(Mago, Casa) :-
    mago(Mago, _, Caracteristicas),
    casa(Casa),
    forall(member(Caracteristica, Caracteristicas), caracteriza(Casa, Caracteristica)).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
casaPosible(Mago, Casa) :-
    magoX(Mago),
    casa(Casa),
    tieneCaracter(Mago, Casa),
    permiteEntrar(Casa, Mago),
    not(odia(Mago, Casa)).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
cadenaDeAmistades(Magos) :-
    forall(member(Mago, Magos), esAmistoso(Mago)),
    cadena(Magos).

esAmistoso(Mago) :-
    mago(Mago, _, Caracteristicas),
    member(amistad, Caracteristicas).

cadena([Mago1, Mago2]) :-
    casaPosible(Mago1, Casa),
    casaPosible(Mago2, Casa).
cadena([Mago1, Mago2 | Magos]) :-
    cadena([Mago1, Mago2]),
    cadena([Mago2 | Magos]).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
esBuenAlumno(Mago) :-
    hizo(Mago, _),
    sinPuntajeNegativo(Mago).

sinPuntajeNegativo(Mago) :-
    forall(hizo(Mago, Accion), not(esNegativa(Accion))).

esNegativa(fueraDeCama).
esNegativa(irA(Lugar)) :-
    lugarProhibido(Lugar, _).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
puntosDeCasa(Casa, Puntaje) :-
    findall(PuntosAlumno, puntosDeAlumnoDeCasa(Casa, PuntosAlumno), Puntos),
    sumlist(Puntos, Puntaje).

puntosDeAlumnoDeCasa(Casa, Puntos) :-
    esDe(Alumno, Casa),
    puntos(Alumno, Puntos).

puntos(Alumno, Puntos) :-
    hizo(Alumno, responder(_, Puntaje, Profesor)),
    puntajeCondicionado(Alumno, Profesor, Puntaje, Puntos).
puntos(Alumno, Puntos) :-
    hizo(Alumno, buenaAccion(_, Puntos)).
puntos(Alumno, Puntos) :-
    hizo(Alumno, Accion),
    esNegativa(Accion),
    puntosPorMalaAccion(Accion, Puntos).

puntajeCondicionado(Alumno, Profesor, Puntaje, Puntos) :-
    alumnoFavorito(Profesor, Alumno),
    Puntos is Puntaje * 2.
puntajeCondicionado(Alumno, Profesor, _, 0) :-
    alumnoOdiado(Profesor, Alumno).
puntajeCondicionado(Alumno, Profesor, Puntaje, Puntaje) :-
    magoX(Alumno),
    profesor(Profesor),
    not(alumnoFavorito(Profesor, Alumno)),
    not(alumnoOdiado(Profesor, Alumno)).

puntosPorMalaAccion(irA(LugarProhibido), Puntos) :-
    lugarProhibido(LugarProhibido, Puntaje),
    Puntos is Puntaje * -1.
puntosPorMalaAccion(fueraDeCama, -50).

profesor(Profesor) :-
    alumnoOdiado(Profesor, _).
profesor(Profesor) :-
    alumnoFavorito(Profesor, _).

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
casaGanadora(Casa) :-
    casa(Casa),
    forall(casa(OtraCasa), tieneMasPuntos(Casa, OtraCasa)).

tieneMasPuntos(Casa, OtraCasa) :-
    puntosDeCasa(Casa, PuntajeMayor),
    puntosDeCasa(OtraCasa, PuntajeMenor),
    PuntajeMayor >= PuntajeMenor.