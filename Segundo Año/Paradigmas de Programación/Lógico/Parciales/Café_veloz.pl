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
tomo(passarella, Consumible) :-
    consumible(Consumible),
    not(tomo(maradona, Consumible)).

% b.
tomi(pedemonti, Consumible) :-
    consumible(Consumible),
    tomo(maradona, Consumible),
    not(tomo(chamot, Consumible)).

% c.
% no se agrega cláusula y con eso es suficiente.

consumible(Consumible) :-
    tomo(_, Consumible).
consumible(Consumible) :-
    maximo(Consumible, _).
consumible(Consumible) :-
    sustanciaProhibida(Consumible).
consumible(Consumible) :-
    composicion(_, Sustancias),
    member(Consumible, Sustancias).

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
atiende(cahe, maradona).
atiende(cahe, chamot).
atiende(cahe, balbo).
atiende(zin, caniggia).
atiende(cureta, pedemonti).
atiende(cureta, basualdo).

chanta(Medico) :-
    medico(Medico),
    forall(atiende(Medico, Jugador), puedeSerSuspendido(Jugador)).

medico(Medico) :-
    atiende(Medico, _).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
nivelFalopez(efedrina, 10).
nivelFalopez(cocaina, 100).
nivelFalopez(extasis, 120).
nivelFalopez(omeprazol, 5).

cuantaFalopaTiene(Jugador, AlteracionEnSangre) :-
    jugador(Jugador),
    findall(NivelAlteracion, nivelAlteracion(Jugador, NivelAlteracion), NivelesDeAlteracion),
    sumlist(NivelesDeAlteracion, AlteracionEnSangre).

nivelAlteracion(Jugador, NivelAlteracion) :-
    tomo(Jugador, Consumible),
    alteracionConsumible(Consumible, NivelAlteracion).

alteracionConsumible(producto(_, _), 0).
alteracionConsumible(sustancia(NombreSustancia), NivelAlteracion) :-
    nivelFalopez(NombreSustancia, NivelAlteracion).
alteracionConsumible(compuesto(NombreCompuesto), NivelAlteracion) :-
    composicion(NombreCompuesto, Sustancias),
    sumaFalopez(Sustancias, NivelAlteracion).

sumaFalopez(Sustancias, FalopezTotal) :-
    findall(Falopez, (member(Sustancia, Sustancias), nivelFalopez(Sustancia, Falopez)), NivelesDeFalopa),
    sumlist(NivelesDeFalopa, FalopezTotal).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
medicoConProblemas(Medico) :-
    findall(Jugador, atiendeJugadorConflictivo(Medico, Jugador), JugadoresConflictivos),
    length(JugadoresConflictivos, Cantidad),
    Cantidad > 3.

atiendeJugadorConflictivo(Medico, Jugador) :-
    atiende(Medico, Jugador),
    esConflictivo(Jugador).

esConflictivo(Jugador) :-
    puedeSerSuspendido(Jugador).
esConflictivo(Jugador) :-
    conoce(Jugador, maradona).

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
programaTVFantinesco(Lista) :-
    findall(Jugador, puedeSerSuspendido(Jugador), JugadoresSuspendidos),
    combinaciones(Lista, JugadoresSuspendidos).

combinaciones([Cabeza | Combinacion], [Cabeza | Resto]) :-
    combinaciones(Combinacion, Resto).
combinaciones(Combinacion, [_ | Resto]):-
    combinaciones(Combinacion, Resto).
combinaciones([], []).