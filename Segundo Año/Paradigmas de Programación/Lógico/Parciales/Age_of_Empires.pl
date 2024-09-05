%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%

% …jugador(Nombre, Rating, Civilizacion).
jugador(juli, 2200, jemeres).
jugador(aleP, 1600, mongoles).
jugador(feli, 500000, persas).
jugador(aleC, 1723, otomanos).
jugador(ger, 1729, ramanujanos).
jugador(juan, 1515, britones).
jugador(marti, 1342, argentinos).

% …tiene(Nombre, QueTiene).
tiene(aleP, unidad(samurai, 199)).
tiene(aleP, unidad(espadachin, 10)).
tiene(aleP, unidad(granjero, 10)).
tiene(aleP, recurso(800, 300, 100)).
tiene(aleP, edificio(casa, 40)).
tiene(aleP, edificio(castillo, 1)).
tiene(juan, unidad(carreta, 10)).

% militar(Tipo, costo(Madera, Alimento, Oro), Categoria).
militar(espadachin, costo(0, 60, 20), infanteria).
militar(arquero, costo(25, 0, 45), arqueria).
militar(mangudai, costo(55, 0, 65), caballeria).
militar(samurai, costo(0, 60, 30), unica).
militar(keshik, costo(0, 80, 50), unica).
militar(tarcanos, costo(0, 60, 60), unica).
militar(alabardero, costo(25, 35, 0), piquero).

% aldeano(Tipo, produce(Madera, Alimento, Oro)).
aldeano(lenador, produce(23, 0, 0)).
aldeano(granjero, produce(0, 32, 0)).
aldeano(minero, produce(0, 0, 23)).
aldeano(cazador, produce(0, 25, 0)).
aldeano(pescador, produce(0, 23, 0)).
aldeano(alquimista, produce(0, 0, 25)).

% edificio(Edificio, costo(Madera, Alimento, Oro)).
edificio(casa, costo(30, 0, 0)).
edificio(granja, costo(0, 60, 0)).
edificio(herreria, costo(175, 0, 0)).
edificio(castillo, costo(650, 0, 300)).
edificio(maravillaMartinez, costo(10000, 10000, 10000)).

%%%%%%%%%%%%    
% Punto 01 %
%%%%%%%%%%%%
esUnAfano(Jugador1, Jugador2) :-
    diferenciaRating(Jugador1, Jugador2, Diferencia),
    Diferencia > 500.

diferenciaRating(Jugador1, Jugador2, Diferencia) :-
    rating(Jugador1, Rating1),
    rating(Jugador2, Rating2),
    Diferencia is Rating1 - Rating2.

rating(Jugador, Rating) :-
    jugador(Jugador, Rating, _).

%%%%%%%%%%%%    
% Punto 02 %
%%%%%%%%%%%%
esEfectivo(Unidad1, Unidad2) :-
    categoria(Unidad1, Categoria1),
    categoria(Unidad2, Categoria2),
    gana(Categoria1, Categoria2).

categoria(Unidad, Categoria) :-
    militar(Unidad, _, Categoria).
categoria(Unidad, aldeano) :-
    aldeano(Unidad, _).

gana(caballeria, arqueria).
gana(arqueria, infanteria).
gana(infanteria, piquero).
gana(piquero, caballeria).
gana(samurai, Unidad) :-
    categoria(Unidad, unica).

%%%%%%%%%%%%    
% Punto 03 %
%%%%%%%%%%%%
alarico(Jugador) :-
    soloTiene(Jugador, infanteria).

soloTiene(Jugador, Categoria) :-
    jugador(Jugador),
    categoria(_, Categoria),
    forall(tiene(Jugador, unidad(Unidad, _)), categoria(Unidad, Categoria)).

jugador(Jugador) :-
    jugador(Jugador).

%%%%%%%%%%%%    
% Punto 04 %
%%%%%%%%%%%%
leonidas(Jugador) :-
    soloTiene(Jugador, piquero).

%%%%%%%%%%%%    
% Punto 05 %
%%%%%%%%%%%%
nomada(Jugador) :-
    jugador(Jugador),
    not(tieneCasa(Jugador)).

tieneCasa(Jugador) :-
    tiene(Jugador, edificio(casa, _)).

%%%%%%%%%%%%    
% Punto 06 %
%%%%%%%%%%%%
cuantoCuesta(Unidad, Costo) :-
    militar(Unidad, Costo, _).
cuantoCuesta(Edificio, Costo) :-
    edificio(Edificio, Costo).
cuantoCuesta(Unidad, costo(0, 50, 0)) :-
    aldeano(Unidad, _).
cuantoCuesta(Unidad, costo(100, 0, 50)) :-
    carretaOUrnaMercante(Unidad).

carretaOUrnaMercante(carreta).
carretaOUrnaMercante(urnaMercante).

%%%%%%%%%%%%    
% Punto 07 %
%%%%%%%%%%%%
produccion(Unidad, Produccion) :-
    aldeano(Unidad, Produccion).
produccion(Unidad, produce(0, 0, 32)) :-
    carretaOUrnaMercante(Unidad).
produccion(keshik, produce(0, 0, 10)).

%%%%%%%%%%%%    
% Punto 08 %
%%%%%%%%%%%%
produccionTotal(Jugador, Recurso, ProduccionTotal) :-
    jugador(Jugador),
    recurso(Recurso),
    findall(Total, produccionDeRecurso(Jugador, Recurso, Total), Totales),
    sumlist(Totales, ProduccionTotal).

produccionDeRecurso(Jugador, Recurso, Total) :-
    tiene(Jugador, unidad(Unidad, _)),
    produccion(Unidad, Produccion),
    costoRecurso(Produccion, Recurso, Total).

recursoDeProduccion(produce(Recurso, _, _), Recurso).
recursoDeProduccion(produce(_, Recurso, _), Recurso).
recursoDeProduccion(produce(_, Recurso, _), Recurso).

recurso(Recurso) :-
    produccion(_, Produccion),
    recursoDeProduccion(Produccion, Recurso).

costoRecurso(produce(Cantidad, _, _), madera, Costo) :-
    Costo is 3 * Cantidad.
costoRecurso(produce(_, Cantidad, _), alimento, Costo) :-
    Costo is 2 * Cantidad.
costoRecurso(produce(_, _, Cantidad), oro, Costo) :-
    Costo is 5 * Cantidad.

%%%%%%%%%%%%    
% Punto 09 %
%%%%%%%%%%%%
estaPeleado(Jugador1, Jugador2) :-
    jugador(Jugador1),
    jugador(Jugador2),
    not(esUnAfano(Jugador1, Jugador2)),
    mismaCantidadUnidades(Jugador1, Jugador2),
    diferenciaProduccion(Jugador1, Jugador2, Diferencia),
    Diferencia < 100.

mismaCantidadUnidades(Jugador1, Jugador2) :-
    cantidadUnidades(Jugador1, _, Cantidad),
    cantidadUnidades(Jugador2, _, Cantidad).

cantidadUnidades(Jugador, Unidad, Cantidad) :-
    findall(Unidad, tiene(Jugador, unidad(Unidad, _)), Unidades),
    length(Unidades, Cantidad).

diferenciaProduccion(Jugador1, Jugador2, Diferencia) :-
    produccionTotalTotal(Jugador1, Total1),
    produccionTotalTotal(Jugador2, Total2),
    Resta is Total1 - Total2,
    abs(Resta, Diferencia).

produccionTotalTotal(Jugador, Total) :-
    findall(Produccion, produccionTotal(Jugador, _, Produccion), Producciones),
    sumlist(Producciones, Total).
    
%%%%%%%%%%%%    
% Punto 10 %
%%%%%%%%%%%%
avanzaA(_, edadMedia).
avanzaA(Jugador, edadFeudal) :-
    tieneAlMenos(Jugador, alimento, 500),
    tiene(Jugador, edificio(casa, _)).
avanzaA(Jugador, edadDeLosCastillos) :-
    tieneAlMenos(Jugador, alimento, 800),
    tieneAlMenos(Jugador, oro, 200),
    heavy(Jugador).
avanzaA(Jugador, edadImperial) :-
    tieneAlMenos(Jugador, alimento, 1000),
    tieneAlMenos(Jugador, oro, 800),
    tiene(Jugador, edificio(castillo)),
    tiene(Jugador, edificio(universidad)).

tieneAlMenos(Jugador, Unidad, Cantidad) :-
    cantidadUnidades(Jugador, Unidad, CantidadQueTiene),
    CantidadQueTiene >= Cantidad.

heavy(Jugador) :-
    tiene(Jugador, edificio(Edificio, _)),
    heavy(Edificio).

heavy(herreria).
heavy(establo).
heavy(galeriaDeTiro).