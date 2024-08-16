%%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%%
% puestoDeComida(comida, precio).
puestoDeComida(hamburguesa, 2000).
puestoDeComida(panchitoConPapas, 1500).
puestoDeComida(lomitoCompleto, 2500).
puestoDeComida(caramelo, 0).

% atraccion(nombre, tranquila(franjaEtaria)).
atraccion(autitosChocadores, tranquila(chicosYAdultos)).
atraccion(casaEmbrujada, tranquila(chicosYAdultos)).
atraccion(laberinto, tranquila(chicosYAdultos)).
atraccion(tobogan, tranquila(chicos)).
atraccion(calesita, tranquila(chicos)).

% atraccion(nombre, intensa(coeficienteDeLanzamiento)).
atraccion(barcoPirata, intensa(14)).
atraccion(tazasChinas, intensa(6)).
atraccion(simulador3D, intensa(2)).

% atracccion(nombre, montaniaRusa(girosInvertidos, duracion)).
atraccion(abismoMortalRecargada, montaniaRusa(3, 134)).
atraccion(paseoPorElBosque, montaniaRusa(0, 45)).

% atraccion(nombre, acuatica)
atraccion(torpedoSalpicon, acuatica).
atraccion(esperoQueHayasTraidoUnaMudaDeRopa, acuatica).

% abre(tipoDeAtraccion, mesDeApertura).
abre(acuatica, septiembre).
abre(acuatica, octubre).
abre(acuatica, noviembre).
abre(acuatica, diciembre).
abre(acuatica, enero).
abre(acuatica, febrero).
abre(acuatica, marzo).

% visitante(nombre, datosSuperficiales(edad, dinero), sentimiento(hambre, aburrimiento))
visitante(eusebio, datosSuperficiales(80, 3000), sentimiento(50, 0)).
visitante(carmela, datosSuperficiales(80, 0), sentimiento(0, 25)).

visitante(joaco, datosSuperficiales(22, 0), sentimiento(100, 100)).
visitante(fede,  datosSuperficiales(36, 1000), sentimiento(50, 0)).

% grupo(nombre, grupo).
grupo(eusebio, viejitos).
grupo(carmela, viejitos).

%%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%%
visitante(Visitante) :-
    visitante(Visitante, _, _).

vieneSolo(Visitante) :-
    visitante(Visitante),
    not(vieneAcompaniado(Visitante)).

vieneAcompaniado(Visitante) :-
    grupo(Visitante, _).

bienestar(Visitante, felicidadPlena) :-
    sentimientosNulos(Visitante),
    vieneAcompaniado(Visitante).

bienestar(Visitante, podriaEstarMejor) :-
    sentimientosNulos(Visitante),
    vieneSolo(Visitante).

bienestar(Visitante, podriaEstarMejor) :-
    sumaSentimientosEntre(Visitante, 1, 50).

bienestar(Visitante, necesitaEntretenerse) :-
    sumaSentimientosEntre(Visitante, 51, 99).

bienestar(Visitante, quiereIrseACasa) :-
    sumaSentimientos(Visitante, Suma),
    Suma >= 100.

sumaSentimientosEntre(Visitante, Base, Tope) :-
    sumaSentimientos(Visitante, Suma),
    between(Base, Tope, Suma).

sumaSentimientos(Visitante, Suma) :-
    visitante(Visitante, _, sentimiento(Hambre, Aburrimiento)),
    Suma is Hambre + Aburrimiento.

sentimientosNulos(Visitante) :-
    sumaSentimientos(Visitante, 0).

%%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%%
comida(Comida) :-
    puestoDeComida(Comida, _).

grupo(Grupo) :-
    grupo(_, Grupo).

dinero(Visitante, Dinero) :-
    visitante(Visitante, datosSuperficiales(_, Dinero), _).

hambre(Visitante, Hambre) :-
    visitante(Visitante, _, sentimiento(Hambre, _)).

edad(Visitante, Edad) :-
    visitante(Visitante, datosSuperficiales(Edad, _), _).

puedeSatisfacer(Grupo, Comida) :-
    comida(Comida),
    grupo(Grupo),
    todosSatisfechos(Grupo, Comida).

todosSatisfechos(Grupo, Comida) :-
    forall(grupo(Integrante, Grupo), satisface(Integrante, Comida)).

satisface(Persona, Comida) :-
    puedeComprar(Persona, Comida),
    leQuitaElHambre(Comida, Persona).

puedeComprar(Visitante, Comida) :-
    dinero(Visitante, Dinero),
    puestoDeComida(Comida, Precio),
    Dinero >= Precio.

leQuitaElHambre(hamburguesa, Visitante) :-
    hambre(Visitante, Hambre),
    Hambre < 50.
leQuitaElHambre(panchitoConPapas, Visitante) :-
    esChico(Visitante).
leQuitaElHambre(lomitoCompleto, Visitante) :-
    visitante(Visitante).
leQuitaElHambre(caramelo, Visitante) :-
    forall(comida(OtraComida), noCompraComidaDistinta(Visitante, caramelo, OtraComida)).

noCompraComidaDistinta(Visitante, Comida, OtraComida) :-
    not(puedeComprar(Visitante, OtraComida)),
    Comida \= OtraComida.

esChico(Visitante) :-
    edad(Visitante, Edad),
    Edad < 13.

%%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%%
% lluviaDeHamburguesas(Visitante, Nombre de Atraccion)
lluviaDeHamburguesas(Visitante, Atraccion) :-
    puedeComprar(Visitante, hamburguesa),
    atraccionVomitiva(Visitante, Atraccion).

atraccionVomitiva(_, tobogan).
atraccionVomitiva(Visitante, Atraccion) :-
    atraccion(Atraccion, TipoDeAtraccion),
    tipoDeAtraccionVomitiva(Visitante, TipoDeAtraccion).

tipoDeAtraccionVomitiva(_, intensa(CoeficienteDeLanzamiento)) :-
    CoeficienteDeLanzamiento > 10.
tipoDeAtraccionVomitiva(Visitante, MontaniaRusa) :-
    esPeligrosa(Visitante, MontaniaRusa).

esPeligrosa(Visitante, montaniaRusa(Giros, _)) :-
    not(esChico(Visitante)),
    not(bienestar(Visitante, necesitaEntretenerse)),
    maximaCantidadDeGiros(Giros).

esPeligrosa(Visitante, montaniaRusa(_, Duracion)) :-
    esChico(Visitante),
    Duracion > 60.

maximaCantidadDeGiros(Giros) :-
    forall(atraccion(_, montaniaRusa(OtrosGiros, _)), OtrosGiros =< Giros).

%%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%%
opcionDeEntretenimiento(Mes, Visitante, Opcion) :-
    opcionParticularDeEntretenimiento(Mes, Visitante, Opcion).

opcionParticularDeEntretenimiento(_, Visitante, PuestoDeComida) :-
    puedeComprar(Visitante, PuestoDeComida).

opcionParticularDeEntretenimiento(_, Visitante, Atraccion) :-
    atraccion(Atraccion, tranquila(FranjaEtaria)),
    puedeAcceder(Visitante, FranjaEtaria).

opcionParticularDeEntretenimiento(_, _, Atraccion) :-
    atraccion(Atraccion, intensa(_)).
    
opcionParticularDeEntretenimiento(_, Visitante, Atraccion) :-
    atraccion(Atraccion, montaniaRusa(Giros, Duracion)),
    not(esPeligrosa(Visitante, montaniaRusa(Giros, Duracion))).

opcionParticularDeEntretenimiento(Mes, _, Atraccion) :-
    atraccion(Atraccion, acuatica),
    abre(acuatica, Mes).

puedeAcceder(Visitante, chicos) :-
    esChico(Visitante).
puedeAcceder(Visitante, chicos) :-
    grupo(Visitante, Grupo),
    not(esChico(Visitante)),
    hayAlgunChicoEnElGrupo(Grupo).

puedeAcceder(_, chicosYAdultos).

hayAlgunChicoEnElGrupo(Grupo) :-
    grupo(Integrante, Grupo),
    esChico(Integrante).