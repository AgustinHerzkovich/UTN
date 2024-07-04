% Base de conocimiento
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
paisContinente(asia, india).
paisContinente(asia, afganistan).
paisContinente(asia, nepal).

paisImportante(argentina).
paisImportante(alemania).

limitrofes(argentina, brasil).
limitrofes(bolivia, brasil).
limitrofes(bolivia, argentina).
limitrofes(argentina, chile).
limitrofes(espania, francia).
limitrofes(alemania, francia).
limitrofes(nepal, india).
limitrofes(china, india).
limitrofes(nepal, china).
limitrofes(afganistan, china).

ocupa(argentina, azul).
ocupa(bolivia, rojo).
ocupa(brasil, verde).
ocupa(chile, negro).
ocupa(ecuador, rojo).
ocupa(alemania, azul).
ocupa(espania, azul).
ocupa(francia, azul).
ocupa(inglaterra, azul).
ocupa(aral, verde).
ocupa(china, negro).
ocupa(india, verde).
ocupa(afganistan, verde).

continente(americaDelSur).
continente(europa).
continente(asia).

% Agregados
pais(Pais):-
    paisContinente(_ , Pais).

jugador(Jugador):-
    ocupa(_ , Jugador).

distintos(Argumento1,Argumento2):-
    Argumento1 \= Argumento2.

% 1. estaEnContinente/2: relaciona un jugador y un continente si el jugador ocupa al menos un país en el continente.
estaEnContinente(Continente,Jugador):-
    ocupa(Pais,Jugador),
    paisContinente(Continente,Pais).

% 2. ocupaContinente/2: relaciona un jugador y un continente si el jugador ocupa totalmente el continente.
ocupaContinente(Continente,Jugador):-
    continente(Continente),
    jugador(Jugador),
    forall(paisContinente(Continente,Pais),ocupa(Pais,Jugador)).

% 3. cubaLibre/1: es verdadero para un país si nadie lo ocupa.
cubaLibre(Pais):-
    pais(Pais),
    not(ocupado(Pais)).

ocupado(Pais):-
    ocupa(Pais , _).

% 4. leFaltaMucho/2: relaciona a un jugador si está en un continente pero le falta ocupar otros 2 países o más.
leFaltaMucho(Jugador,Continente):-
    estaEnContinente(Continente,Jugador),
    paisContinente(Continente,Pais1),
    paisContinente(Continente,Pais2),
    distintos(Pais1,Pais2),
    noOcupa(Pais1,Jugador),
    noOcupa(Pais2,Jugador).

noOcupa(Pais,Jugador):-
    pais(Pais),
    jugador(Jugador),
    not(ocupa(Pais,Jugador)).

% 5. sonLimitrofes/2: relaciona dos países si son limítrofes considerando que si A es limítrofe de B, entonces B también es limítrofe de A.
sonLimitrofes(Pais1,Pais2):-
    limitrofes(Pais1,Pais2).
sonLimitrofes(Pais1,Pais2):-
    limitrofes(Pais2,Pais1). 

% 6. tipoImportante/1: un jugador es importante si ocupa todos los países importantes.
tipoImportante(Jugador):-
    jugador(Jugador),
    forall(paisImportante(PaisImportante),ocupa(PaisImportante,Jugador)).

% 7. estaEnElHorno/1: un país está en el horno si todos sus países limítrofes están ocupados por el mismo jugador que no es el mismo que ocupa ese país.
estaEnElHorno(Pais):-
    ocupa(Pais,Jugador),
    jugador(OtroJugador),
    distintos(Jugador,OtroJugador),
    forall(sonLimitrofes(Pais,PaisLimitrofe),ocupa(PaisLimitrofe,OtroJugador)).

% 8. esCompartido/1: un continente es compartido si hay dos o más jugadores en él.
esCompartido(Continente):-
    estaEnContinente(Continente,Jugador1),
    estaEnContinente(Continente,Jugador2),
    distintos(Jugador1,Jugador2).