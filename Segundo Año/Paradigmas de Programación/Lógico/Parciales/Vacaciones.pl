%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% seVa(Persona, [Lugar]).
seVa(dodain, [pehuenia, sanMartinDeLosAndes, esquel, sarmiento, camarones, playasDoradas]).
seVa(alf, [bariloche, sanMartinDeLosAndes, elBolson]).
seVa(nico, [marDelPlata]).
seVa(vale, [elCalafate, elBolson]).
seVa(martu, Vacaciones) :-
    findall(Lugar, viajanNicoYAlf(Lugar), Vacaciones).

viajanNicoYAlf(Lugar) :-
    seVa(nico, Lugares1),
    seVa(alf, Lugares2),
    member(Lugar, Lugares1),
    member(Lugar, Lugares2).

/*
No es necesario agregar una cláusula para juan ya que no aún no sabe a dónde va, y
por principio de universo cerrado, lo desconocido es falso.

No es necesario agregar una cláusula para carlos por el mismo concepto.
*/

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
% atracciones(Lugar, [Atracción]).
% atracción: parqueNacional(Nombre). cerro(Nombre, Altura). cuerpoAgua(Nombre, SePuedePescar, TemperaturaPromedio). playa(DiferenciaPromedio). excursion(Nombre).
atracciones(esquel, [parqueNacional(losAlerces), excursion(trochita), excursion(trevelin)]).
atracciones(pehuenia, [cerro(bateaMahuida, 2000), cuerpoAgua(moquehue, si, 14), cuerpoAgua(alumine, si, 19)]).

vacacionesCopadas(Persona) :-
    seVa(Persona, Vacaciones),
    forall(member(Lugar, Vacaciones), tieneAtraccionCopada(Lugar)).

tieneAtraccionCopada(Lugar) :-
    atracciones(Lugar, Atracciones),
    member(Atraccion, Atracciones),
    copada(Atraccion).

copada(cerro(_, Altura)) :-
    Altura > 2000.
copada(cuerpoAgua(_, si, _)).
copada(cuerpoAgua(_, _, Temperatura)) :-
    Temperatura > 20.
copada(playa(Diferencia)) :-
    Diferencia < 5.
copada(excursion(Nombre)) :-
    masDe7Letras(Nombre).
copada(parqueNacional(_)).

masDe7Letras(Palabra) :-
    atom_chars(Palabra, Letras),
    length(Letras, Cantidad),
    Cantidad > 7.

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
noSeCruzaron(Persona1, Persona2) :-
    seVa(Persona1, Lugares1),
    seVa(Persona2, Lugares2),
    intersection(Lugares1, Lugares2, []).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
costoDeVida(sarmiento, 100).
costoDeVida(esquel, 150).
costoDeVida(pehuenia, 180).
costoDeVida(sanMartinDeLosAndes, 150).
costoDeVida(camarones, 135).
costoDeVida(playasDoradas, 170).
costoDeVida(bariloche, 140).
costoDeVida(elCalafate, 240).
costoDeVida(elBolson, 145).
costoDeVida(marDelPlata, 140).

vacacionesGasoleras(Persona) :-
    seVa(Persona, Vacaciones),
    forall(member(Destino, Vacaciones), gasolero(Destino)).

gasolero(Destino) :-
    costoDeVida(Destino, CostoDeVida),
    CostoDeVida < 160.

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
itinerariosPosibles(Persona, Itinerarios) :-
    seVa(Persona, Vacaciones),
    permutacion(Vacaciones, Itinerarios).

permutacion([], []).
permutacion([Cabeza | Resto], Permutacion) :-
    permutacion(Resto, PermutacionResto),
    insertar(Cabeza, PermutacionResto, Permutacion).

insertar(X, Lista, [X|Lista]).
insertar(X, [Y|Resto], [Y|RestoConX]) :-
    insertar(X, Resto, RestoConX).