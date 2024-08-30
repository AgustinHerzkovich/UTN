%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% cree(Persona, PersonajeDeFantasía).
cree(gabriel, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).
cree(juan, conejoDePascua).
cree(macarena, reyesMagos).
cree(macarena, magoCapria).
cree(macarena, campanita).

% principio de universo cerrado ya que Diego no cree en nadie, por ende no tiene cláusula.

% sueños: cantante(CantidadDeDiscos). futbolista(Equipo). ganarLoteria(Números).
% suenia(Persona, Sueño).
suenia(gabriel, ganarLoteria([9, 5])).
suenia(gabriel, futbolista(arsenal)).
suenia(juan, cantante(100000)).
suenia(macarena, cantante(10000)).

% polimorfismo con el predicado suenia, dado que los functores de sueños tienen distinta forma.
% principio de universo cerrado ya que macarena no quiere ganar la lotería, por ende no tiene cláusula.

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
esAmbiciosa(Persona) :-
    persona(Persona),
    findall(DificultadSuenio, sueniaConDificultad(Persona, DificultadSuenio), Dificultades),
    sumlist(Dificultades, Total),
    Total > 20.

persona(Persona) :-
    suenia(Persona, _).

sueniaConDificultad(Persona, Dificultad) :-
    suenia(Persona, Suenio),
    dificultadSuenio(Suenio, Dificultad).

dificultadSuenio(cantante(Discos), 6) :-
    Discos >= 500000.
dificultadSuenio(cantante(Discos), 4) :-
    Discos < 500000.
dificultadSuenio(ganarLoteria(Numeros), Dificultad) :-
    length(Numeros, Cantidad),
    Dificultad is 10 * Cantidad.
dificultadSuenio(futbolista(Equipo), 3) :-
    equipoChico(Equipo).
dificultadSuenio(futbolista(Equipo), 16) :-
    not(equipoChico(Equipo)).

equipoChico(arsenal).
equipoChico(aldosivi).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
tieneQuimica(Personaje, Persona) :-
    cree(Persona, Personaje),
    sueniaBien(Persona, Personaje).

sueniaBien(Persona, campanita) :-
    sueniaConDificultad(Persona, Dificultad),
    Dificultad < 5.
sueniaBien(Persona, Personaje) :-
    persona(Persona),
    not(esCampanita(Personaje)),
    todosSueniosPuros(Persona),
    not(esAmbiciosa(Persona)).

esCampanita(campanita).

todosSueniosPuros(Persona) :-
    forall(suenia(Persona, Suenio), esPuro(Suenio)).

esPuro(futbolista(_)).
esPuro(cantante(Discos)) :-
    Discos < 200000.

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
amigo(campanita, reyesMagos).
amigo(campanita, conejoDePascua).
amigo(conejoDePascua, cavenaghi).

puedeAlegrar(Personaje, Persona) :-
    suenia(Persona, _),
    tieneQuimica(Personaje, Persona),
    seEncuentraBien(Personaje).

seEncuentraBien(Personaje) :-
    personaje(Personaje),
    not(estaEnfermo(Personaje)).
seEncuentraBien(Personaje) :-
    personajeDeBackup(Personaje, PersonajeBackup),
    seEncuentraBien(PersonajeBackup).

personaje(Personaje) :-
    cree(_, Personaje).

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).

personajeDeBackup(Personaje, PersonajeBackup) :-
    amigo(Personaje, PersonajeBackup).
personajeDeBackup(Personaje, PersonajeBackup) :-
    amigo(Personaje, Amigo),
    personajeDeBackup(Amigo, PersonajeBackup).