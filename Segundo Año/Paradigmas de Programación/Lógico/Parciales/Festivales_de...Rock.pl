%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
anioActual(2015).

%festival(nombre, lugar, bandas, precioBase).
%lugar(nombre, capacidad).
festival(lulapaluza, lugar(hipodromo, 40000), [miranda, paulMasCarne, muse], 500).
festival(mostrosDelRock, lugar(granRex, 10000), [kiss, judasPriest, blackSabbath], 1000).
festival(personalFest, lugar(geba, 5000), [tanBionica, miranda, muse, pharrellWilliams], 300).
festival(cosquinRock, lugar(aerodromo, 2500), [erucaSativa, laRenga], 400).

%banda(nombre, año, nacionalidad, popularidad).
banda(paulMasCarne,1960, uk, 70).
banda(muse,1994, uk, 45).
banda(kiss,1973, us, 63).
banda(erucaSativa,2007, ar, 60).
banda(judasPriest,1969, uk, 91).
banda(tanBionica,2012, ar, 71).
banda(miranda,2001, ar, 38).
banda(laRenga,1988, ar, 70).
banda(blackSabbath,1968, uk, 96).
banda(pharrellWilliams,2014, us, 85).

%entradasVendidas(nombreDelFestival, tipoDeEntrada, cantidadVendida).
% tipos de entrada: campo, plateaNumerada(numero de fila), plateaGeneral(zona).
entradasVendidas(lulapaluza,campo, 600).
entradasVendidas(lulapaluza,plateaGeneral(zona1), 200).
entradasVendidas(lulapaluza,plateaGeneral(zona2), 300).
entradasVendidas(mostrosDelRock,campo,20000).
entradasVendidas(mostrosDelRock,plateaNumerada(1),40).
entradasVendidas(mostrosDelRock,plateaNumerada(2),0).
% … y asi para todas las filas
entradasVendidas(mostrosDelRock,plateaNumerada(10),25).
entradasVendidas(mostrosDelRock,plateaGeneral(zona1),300).
entradasVendidas(mostrosDelRock,plateaGeneral(zona2),500).

plusZona(hipodromo, zona1, 55).
plusZona(hipodromo, zona2, 20).
plusZona(granRex, zona1, 45).
plusZona(granRex, zona2, 30).
plusZona(aerodromo, zona1, 25).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
estaDeModa(Banda) :-
    bandaReciente(Banda),
    popularidadMayorA(70, Banda).

bandaReciente(Banda) :-
    banda(Banda, AnioSurgimiento, _, _),
    anioActual(AnioActual),
    AnioActual - AnioSurgimiento =< 5.

popularidadMayorA(Numero, Banda) :-
    banda(Banda, _, _, Popularidad),
    Popularidad > Numero.

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
esCareta(Festival) :-
    participanBandasDeModa(Festival).
esCareta(Festival) :-
    noTieneEntradasRazonables(Festival).
esCareta(Festival) :-
    participa(miranda, Festival).

participanBandasDeModa(Festival) :-
    participa(Banda1, Festival),
    participa(Banda2, Festival),
    Banda1 \= Banda2,
    estaDeModa(Banda1),
    estaDeModa(Banda2).

participa(Banda, Festival) :-
    festival(Festival, _, Bandas, _),
    member(Banda, Bandas).

noTieneEntradasRazonables(Festival) :-
    esFestival(Festival),
    forall(entradasVendidas(Festival, Entrada, _), not(entradaRazonable(Festival, Entrada))).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
entradaRazonable(Festival, plateaGeneral(Zona)) :-
    festival(Festival, lugar(Lugar, _), _, _),
    plusZona(Lugar, Zona, Plus),
    precioEntrada(Festival, plateaGeneral(Zona), Precio),
    PorcentajeDePrecio is Precio * 0.1,
    Plus < PorcentajeDePrecio.
entradaRazonable(Festival, campo) :-
    precioEntrada(Festival, campo, Precio),
    popularidadTotal(Festival, Popularidad),
    Precio < Popularidad.
entradaRazonable(Festival, plateaNumerada(Fila)) :-
    esFestival(Festival),
    forall(participa(Banda, Festival), not(estaDeModa(Banda))),
    precioEntrada(Festival, plateaNumerada(Fila), Precio),
    Precio =< 750.
entradaRazonable(Festival, plateaNumerada(Fila)) :-
    esFestival(Festival),
    forall(participa(Banda, Festival), estaDeModa(Banda)),
    precioMenorAEstadioOPopularidad(Festival, plateaNumerada(Fila)).

popularidadTotal(Festival, Popularidad) :-
    festival(Festival, _, Bandas, _),
    findall(PopularidadDeBanda, (member(Banda, Bandas), popularidadBanda(Banda, PopularidadDeBanda)), Popularidades),
    sumlist(Popularidades, Popularidad).

precioMenorAEstadioOPopularidad(Festival, Entrada) :-
    festival(Festival, lugar(_, Capacidad), _, _),
    precioEntrada(Festival, Entrada, Precio),
    Precio < Capacidad.
precioMenorAEstadioOPopularidad(Festival, Entrada) :-
    precioEntrada(Festival, Entrada, Precio),
    popularidadTotal(Festival, Popularidad),
    Precio < Popularidad.

precioFestival(Festival, Precio) :-
    festival(Festival, _, _, Precio).

precioEntrada(Festival, Entrada, Precio) :-
    precioFestival(Festival, PrecioBase),
    agregadoPorEntrada(Festival, Entrada, PrecioBase, Precio).

agregadoPorEntrada(_, campo, PrecioBase, PrecioBase).
agregadoPorEntrada(_, plateaNumerada(Fila), PrecioBase, Precio) :-
    Precio is PrecioBase + (200 * Fila).
agregadoPorEntrada(Festival, plateaGeneral(Zona), PrecioBase, Precio) :-
    festival(Festival, lugar(Lugar, _), _, PrecioBase),
    plusZona(Lugar, Zona, Plus),
    Precio is PrecioBase + Plus.

esFestival(Festival) :-
    festival(Festival, _, _, _).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
nacanpop(Festival) :-
    esFestival(Festival),
    forall(participa(Festival, Banda), esNacional(Banda)),
    entradaRazonable(Festival, _).

esNacional(Banda) :-
    banda(Banda, _, ar, _).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
recaudacion(Festival, Recaudacion) :-
    esFestival(Festival),
    findall(Venta, venta(Festival, Venta), Ventas),
    sumlist(Ventas, Recaudacion).

venta(Festival, Venta) :-
    entradasVendidas(Festival, Entrada, Cantidad),
    precioEntrada(Festival, Entrada, Precio),
    Venta is Cantidad * Precio.

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
estaBienPlaneado(Festival) :-
    festival(Festival, _, Bandas, _),
    crecenEnPopularidad(Bandas),
    cierraFestival(Banda, Bandas),
    esLegendaria(Banda).

crecenEnPopularidad([]). 
crecenEnPopularidad([_]). 
crecenEnPopularidad([Banda1, Banda2 | Bandas]) :-
    popularidadBanda(Banda1, Popularidad1),
    popularidadBanda(Banda2, Popularidad2),
    Popularidad2 >= Popularidad1, 
    crecenEnPopularidad([Banda2 | Bandas]). 

popularidadBanda(Banda, Popularidad) :-
    banda(Banda, _, _, Popularidad).

cierraFestival(Banda, Bandas) :-
    length(Bandas, Cantidad),
    nth1(Cantidad, Bandas, Banda).

esLegendaria(Banda) :-
    banda(Banda, Anio, Nacionalidad, Popularidad),
    forall(popularidadBanda(_, OtraPopularidad), Popularidad >= OtraPopularidad),
    Anio < 1980,
    internacional(Nacionalidad).

internacional(Nacionalidad) :-
    Nacionalidad \= ar.