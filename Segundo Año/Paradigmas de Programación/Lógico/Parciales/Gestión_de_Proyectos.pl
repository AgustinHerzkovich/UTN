%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%

% tarea(nombre, duracion, tareasAnterioresRequeridas).
% tareaOpcional(nombre, cantidadPersonas, duracion).

proyecto(saeta, tarea(planificacion, 3, [])).
proyecto(saeta, tarea(encuesta, 5, [planificacion])).
proyecto(saeta, tarea(analisis, 5, [encuesta])).
proyecto(saeta, tarea(limpieza, 3, [planificacion])).
proyecto(saeta, tarea(disenio, 6, [analisis])).
proyecto(saeta, tarea(construccion, 5, [disenio, limpieza])).
proyecto(saeta, tarea(ejecucion, 4, [construccion])).
proyecto(saeta, tareaOpcional(presentacion, 4, 10)).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
tareaSiguiente(TareaPrevia, TareaPosterior) :-
    mismoProyecto(TareaPrevia, TareaPosterior),
    esSiguiente(TareaPosterior, TareaPrevia).

mismoProyecto(Tarea1, Tarea2) :-
    proyecto(Proyecto, Tarea1),
    proyecto(Proyecto, Tarea2).

esSiguiente(TareaSiguiente, TareaAnterior) :-
    tareasAnteriores(TareaSiguiente, TareasAnteriores),
    member(NombreTareaAnterior, TareasAnteriores),
    tareaConNombre(NombreTareaAnterior, TareaAnterior).

tareasAnteriores(tarea(_, _, TareasAnteriores), TareasAnteriores).

tareaConNombre(Nombre, tarea(Nombre, _, _)).
tareaConNombre(Nombre, tareaOpcional(Nombre, _, _)).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
esPesada(Tarea) :-
    duracionMayorA(Tarea, 5).
esPesada(Tarea) :-
    requiereMasDeUnaTarea(Tarea).
esPesada(tareaOpcional(_, 1, _)).

duracion(tarea(_, Duracion, _), Duracion).
duracion(tareaOpcional(_, _, Duracion), Duracion).

duracionMayorA(Tarea, Minimo) :-
    duracion(Tarea, Duracion),
    Duracion > Minimo.

requiereMasDeUnaTarea(tarea(_, _, TareasRequeridas)) :-
    member(Tarea1, TareasRequeridas),
    member(Tarea2, TareasRequeridas),
    Tarea1 \= Tarea2.

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
nivelTarea(Tarea, Nivel) :-
    tarea(Tarea),
    dificultadTarea(Tarea, Nivel).
dificultadTarea(Tarea, final) :-
    noTieneTareasSiguientes(Tarea).
dificultadTarea(tarea(_, _, []), inicial).
dificultadTarea(Tarea, intermedia) :-
    tarea(Tarea),
    not(dificultadTarea(Tarea, final)),
    not(dificultadTarea(Tarea, inicial)).

noTieneTareasSiguientes(Tarea) :-
    tarea(Tarea),
    not(tareaSiguiente(Tarea, _)).

tarea(Tarea) :-
    proyecto(_, Tarea).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
camino(Tarea1, Tarea2, Camino) :-
    tarea(Tarea1),
    tarea(Tarea2),
    findall(Tarea, tareaEntre(Tarea1, Tarea2, Tarea), TareasIntermedias),
    sinRepetidos(TareasIntermedias, Camino).

tareaEntre(TareaInferior, _, TareaInferior).
tareaEntre(TareaInferior, _, TareaIntermedia) :-
    tareaSiguiente(TareaInferior, TareaIntermedia).
tareaEntre(TareaInferior, TareaSuperior, TareaIntermedia) :-
    tareaSiguiente(TareaInferior, TareaSiguiente),
    tareaEntre(TareaSiguiente, TareaSuperior, TareaIntermedia).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
esPesado(Camino) :-
    camino(_, _, Camino),
    forall(member(Tarea, Camino), esPesada(Tarea)),
    duracionTotalMayorA(Camino, 100).

duracionTotalMayorA(Camino, Limite) :-
    duracionTotal(Camino, Duracion),
    Duracion > Limite.

duracionTotal(Camino, DuracionTotal) :-
    findall(Duracion, duracionDeTareaDeCamino(Camino, Duracion), Duraciones),
    sumlist(Duraciones, DuracionTotal).

duracionDeTareaDeCamino(Camino, DuracionTarea) :-
    member(Tarea, Camino),
    duracion(Tarea, DuracionTarea).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
cantidadTareasAnteriores(Tarea, Cantidad) :-
    tarea(Tarea),
    findall(TareaAnterior, precede(TareaAnterior, Tarea), TareasAnteriores),
    sinRepetidos(TareasAnteriores, TareasAnterioresSinRepetir),
    length(TareasAnterioresSinRepetir, Cantidad).

precede(TareaAnterior, TareaPosterior) :-
    tareaSiguiente(TareaAnterior, TareaPosterior).
precede(TareaAnterior, TareaPosterior) :-
    precede(TareaIntermedia, TareaPosterior),
    tareaSiguiente(TareaAnterior, TareaIntermedia).

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
caminoCriticoYDuracion(Proyecto, CaminoCritico, Duracion) :-
    proyecto(Proyecto, _),
    caminoCritico(Proyecto, CaminoCritico),
    duracionTotal(CaminoCritico, Duracion).

caminoCritico(Proyecto, CaminoCritico) :-
    proyecto(Proyecto, _),
    camino(_, _, CaminoCritico),
    forall(caminoDeProyecto(Proyecto, Camino), duraMas(CaminoCritico, Camino)).

duraMas(CaminoMayor, CaminoMenor) :-
    duracionTotal(CaminoMayor, DuracionMayor),
    duracionTotal(CaminoMenor, DuracionMenor),
    DuracionMayor >= DuracionMenor.

caminoDeProyecto(Proyecto, Camino) :-
    proyecto(Proyecto, Tarea1),
    proyecto(Proyecto, Tarea2),
    Tarea1 \= Tarea2,
    camino(Tarea1, Tarea2, Camino).

%%%%%%%%%%%%
% Punto 08 %
%%%%%%%%%%%%
esCoherente(Proyecto) :-
    hayTareaDeDificultad(Proyecto, final),
    hayTareaDeDificultad(Proyecto, inicial),
    hayTareaPesada(Proyecto),
    noHayTareasSueltas(Proyecto).

hayTareaDeDificultad(Proyecto, Dificultad) :-
    proyecto(Proyecto, Tarea),
    dificultadTarea(Tarea, Dificultad).

hayTareaPesada(Proyecto) :-
    proyecto(Proyecto, Tarea),
    esPesada(Tarea).

noHayTareasSueltas(Proyecto) :-
    proyecto(Proyecto, _),
    forall(proyecto(Proyecto, Tarea), not(esSuelta(Tarea))).

esSuelta(Tarea) :-
    not(tareaSiguiente(_, Tarea)),
    not(tareaSiguiente(Tarea, _)),
    not(esOpcional(Tarea)).

tareaOpcional(Tarea) :-
    tarea(Tarea),
    esOpcional(Tarea).

esOpcional(tareaOpcional(_, _, _)).