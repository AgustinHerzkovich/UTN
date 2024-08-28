%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
cuchillo(juan, palo).
cuchillo(pedro, palo).
cuchillo(ana, metal).
cuchillo(oscar, metal).

profesion(ana, costurera).
profesion(juan, herrero).
profesion(pedro, carpintero).
profesion(oscar, herrero).

anda(julia , daniel).
anda(julia , jorge).
anda(julia , raul).
anda(olga , jose).
anda(olga , claudio).
anda(olga , felipe).
anda(olga , carlos).

parece(daniel, buenaGente).
parece(jorge, buenaGente).
parece(raul, malandra).
parece(jose, ingeniero).
parece(claudio, periodista).
parece(felipe, ingeniero).
parece(carlos, contador).

%intenta(Persona, Tarea, Resultado, Fecha)
intenta(juan, paradigmas, 2, fecha(20,2,2004)).
intenta(juan, paradigmas, 2, fecha(20,2,2005)).
intenta(juan, paradigmas, 4, fecha(20,12,2005)).
intenta(pedro, romeoYJulieta, risas, fecha(20,2,2010)).
intenta(pedro, romeoYJulieta, llantos, fecha(20,2,2011)).
intenta(cachito, senador, [propuestas,honestidad,apoyoDeLosMedios, equipo, fortuna], fecha(27,10,2013)).

%exito(Tarea, Requisito).
exito( paradigmas, materia(4)).
exito(romeoYJulieta, teatro(drama,llantos)).
exito(laJaulaDeLasLocas, teatro(comedia, risas)).
exito(senador, politico([propuestas, honestidad, equipo])).
exito(diputado, politico([propuestas, apoyoDeLosMedios])).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% a.
enCasaDeHerreroCuchilloDePalo1(Alguien) :-
    profesion(Alguien, herrero),
    cuchillo(Alguien, palo).

% b.
enCasaDeHerreroCuchilloDePalo2 :-
    forall(herrero(Herrero), cuchillo(Herrero, palo)).

herrero(Herrero) :-
    profesion(Herrero, herrero).

% c.
enCasaDeHerreroCuchilloDePalo3 :-
    cantidadHerreros(Cantidad1),
    cantidadHerrerosDePalo(Cantidad2),
    Mitad is Cantidad1 / 2,
    Cantidad2 > Mitad.

cantidadHerreros(Cantidad) :-
    findall(Herrero, herrero(Herrero), Herreros),
    length(Herreros, Cantidad).

cantidadHerrerosDePalo(Cantidad) :-
    findall(HerreroPalo, enCasaDeHerreroCuchilloDePalo1(HerreroPalo), HerrerosPalos),
    length(HerrerosPalos, Cantidad).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
quienEres(Persona, Personalidad) :-
    anda(Persona, _),
    findall(Caracteristica, caracteristicaDeJunta(Persona, Caracteristica), Caracteristicas),
    caracteristicaMasRepetida(Caracteristicas, Personalidad).

caracteristicaDeJunta(Persona, Caracteristica) :-
    anda(Persona, Junta),
    parece(Junta, Caracteristica).

caracteristicaMasRepetida(Caracteristicas, Caracteristica) :-
    member(Caracteristica, Caracteristicas),
    forall(member(OtraCaracteristica, Caracteristicas), apareceMas(Caracteristica, OtraCaracteristica, Caracteristicas)).

apareceMas(Caracteristica, OtraCaracteristica, Caracteristicas) :-
    cantidadApariciones(Caracteristica, Caracteristicas, Cantidad1),
    cantidadApariciones(OtraCaracteristica, Caracteristicas, Cantidad2),
    Cantidad1 >= Cantidad2.

cantidadApariciones(Caracteristica, Caracteristicas, Cantidad) :-
    findall(_, member(Caracteristica, Caracteristicas), Lista),
    length(Lista, Cantidad).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
laTerceraEsLaVencida(Persona, Tarea) :-
    distinct((Persona, Tarea), (intentosPorElExito(Persona, Tarea, 3),
    alcanzoElExito(Persona, Tarea))).

intentosPorElExito(Persona, Tarea, CantidadIntentos) :-
    intenta(Persona, Tarea, _, _),
    findall(_, intenta(Persona, Tarea, _, _), Intentos),
    length(Intentos, CantidadIntentos).

alcanzoElExito(Persona, Tarea) :-
    intenta(Persona, Tarea, Resultado, _),
    esSuficiente(Tarea, Resultado).

esSuficiente(Materia, Nota) :-
    exito(Materia, materia(NotaAprobacion)),
    Nota >= NotaAprobacion.
esSuficiente(ObraDeTeatro, RespuestaPublico) :-
    exito(ObraDeTeatro, teatro(RespuestaPublico, _)).
esSuficiente(ObraDeTeatro, RespuestaPublico) :-
    exito(ObraDeTeatro, teatro(_, RespuestaPublico)).
esSuficiente(CandidaturaPolitica, Caracteristicas) :-
    exito(CandidaturaPolitica, politico(Requisitos)),
    subconjunto(Requisitos, Caracteristicas).

subconjunto([],_).
subconjunto([X|Xs],L):-
    sinElemento(X,L,L2),
    subconjunto(Xs,L2).

sinElemento(E,[E|Xs],Xs).
sinElemento(E,[X|Xs],[X|XsSinE]):-
sinElemento(E,Xs,XsSinE).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
% Refran: "Más vale tarde que nunca"
% realizo(Persona, Tarea, FechaRealizacion).
realizo(juan, entregarInforme, '2024-08-20').
realizo(maria, hacerPresentacion, '2024-08-22').
realizo(pedro, entregarInforme, '2024-08-25').
realizo(ana, hacerPresentacion, '2024-08-24').
realizo(juan, pagarFactura, '2024-08-26').
realizo(maria, pagarFactura, '2024-08-28').

% fechaLimite(Tarea, FechaLimite).
fechaLimite(entregarInforme, '2024-08-23').
fechaLimite(hacerPresentacion, '2024-08-21').
fechaLimite(pagarFactura, '2024-08-25').

% masValeTardeQueNunca(Persona, Tarea): Se cumple si la persona realizó la tarea después de la fecha límite.
masValeTardeQueNunca(Persona, Tarea) :-
    realizo(Persona, Tarea, FechaRealizacion),
    fechaLimite(Tarea, FechaLimite),
    FechaRealizacion @> FechaLimite.