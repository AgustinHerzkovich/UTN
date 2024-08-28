%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
%tarea(agente, tarea, ubicacion)
%tareas:
%  ingerir(descripcion, tamaño, cantidad)
%  apresar(malviviente, recompensa)
%  asuntosInternos(agenteInvestigado)
%  vigilar(listaDeNegocios)

tarea(vigilanteDelBarrio, ingerir(pizza, 1.5, 2), laBoca).
tarea(vigilanteDelBarrio, vigilar([pizzeria, heladeria]), barracas).
tarea(canaBoton, asuntosInternos(vigilanteDelBarrio), barracas).
tarea(sargentoGarcia, vigilar([pulperia, haciendaDeLaVega, plaza]), puebloDeLosAngeles).
tarea(sargentoGarcia, ingerir(vino, 0.5, 5), puebloDeLosAngeles).
tarea(sargentoGarcia, apresar(elzorro, 100), puebloDeLosAngeles). 
tarea(vega, apresar(neneCarrizo,50), avellaneda).
tarea(jefeSupremo, vigilar([congreso,casaRosada,tribunales]), laBoca).
tarea(zorro, vigilar([casaDeLaMoneda, parque, negocioDeAlfajores]), quilmes).
tarea(mariachi, ingerir(tacos, 2.0, 3), puebloDeLosAngeles).
tarea(mariachi, vigilar([tiendaDeSombreros, cantina]), avellaneda).
tarea(zorro, apresar(bandidos, 200), puebloDeLosAngeles).

ubicacion(puebloDeLosAngeles).
ubicacion(avellaneda).
ubicacion(barracas).
ubicacion(marDelPlata).
ubicacion(laBoca).
ubicacion(uqbar).
ubicacion(buenosAires).
ubicacion(quilmes).

%jefe(jefe, subordinado)
jefe(jefeSupremo,vega).
jefe(vega, vigilanteDelBarrio).
jefe(vega, canaBoton).
jefe(jefeSupremo, sargentoGarcia).
jefe(sargentoGarcia, zorro).
jefe(sargentoGarcia, mariachi).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
frecuenta(Agente, Ubicacion) :-
    tarea(Agente, _, Ubicacion).
frecuenta(Agente, buenosAires) :-
    agente(Agente).
frecuenta(vega, quilmes).
frecuenta(Agente, marDelPlata) :-
    vigilaAlfajores(Agente).

agente(Agente) :-
    jefe(Agente, _).
agente(Agente) :-
    jefe(_, Agente).

vigilaAlfajores(Agente) :-
    tarea(Agente, vigilar(Negocios), _),
    member(negocioDeAlfajores, Negocios).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
inaccesible(Lugar) :-
    ubicacion(Lugar),
    forall(agente(Agente), not(frecuenta(Agente, Lugar))).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
afincado(Agente) :-
    tarea(Agente, _, Ubicacion),
    forall(tarea(Agente, _, OtraUbicacion), sonIguales(Ubicacion, OtraUbicacion)).

sonIguales(X, X).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
cadenaDeMando([Jefe, Subordinado]) :-
    jefe(Jefe, Subordinado).
cadenaDeMando([Jefe, Subordinado | Agentes]) :-
    jefe(Jefe, Subordinado),
    cadenaDeMando([Subordinado | Agentes]).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
agentePremiado(Agente) :-
    agente(Agente),
    agenteConMejorPuntuacion(Agente).

agenteConMejorPuntuacion(Agente) :-
    forall(agente(OtroAgente), tieneMejorPuntuacion(Agente, OtroAgente)).

tieneMejorPuntuacion(Agente, OtroAgente) :-
    puntuacion(Agente, Puntuacion1),
    puntuacion(OtroAgente, Puntuacion2),
    Puntuacion1 >= Puntuacion2.

puntuacion(Agente, Puntuacion) :-
    findall(Puntos, puntosDeAgente(Agente, Puntos), PuntajesTotales),
    sumlist(PuntajesTotales, Puntuacion).

puntosDeAgente(Agente, Puntos) :-
    tarea(Agente, vigilar(Negocios), _),
    length(Negocios, CantidadNegocios),
    Puntos is CantidadNegocios * 5.
puntosDeAgente(Agente, Puntos) :-
    tarea(Agente, ingerir(Consumible), _),
    unidad(Consumible, Unidad),
    Puntos is Unidad * -10.
puntosDeAgente(Agente, Puntos) :-
    tarea(Agente, apresar(_, Recompensa), _),
    Puntos is Recompensa / 2.
puntosDeAgente(Agente, Puntos) :-
    tarea(Agente, asuntosInternos(AgenteInvestigado), _),
    puntosDeAgente(AgenteInvestigado, PuntosInvestigados),
    Puntos is PuntosInvestigados * 2.

unidad((_, Tamanio, Cantidad), Unidad) :-
    Unidad is Tamanio * Cantidad.

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
/*
Polimorfismo: Se utiliza polimorfismo al definir predicados como tarea/3, 
que acepta distintos tipos de tareas (ingerir/3, apresar/2, asuntosInternos/1, vigilar/1). 
Esto permite aplicar las mismas reglas y predicados a diferentes estructuras de datos.

Orden superior: Se aplica en predicados como puntuacion/2, que usa findall/3 y sumlist/2 para trabajar 
con listas de puntajes, lo que permite procesar colecciones de datos y pasar predicados como parámetros a otros predicados.

Inversibilidad: Muchos predicados, como agente/1 o frecuenta/2, están diseñados para funcionar en ambas direcciones 
(consultar y generar), permitiendo obtener resultados tanto desde los hechos como desde las consultas inversas. 
*/