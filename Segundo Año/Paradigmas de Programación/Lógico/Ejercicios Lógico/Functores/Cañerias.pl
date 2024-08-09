%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
precioCanieria(Canieria, Precio) :-
    precios(Canieria, Precios),
    sumlist(Precios, Precio).

precios(Canieria, Precios) :-
    member(Pieza, Canieria),
    findall(Precio, precio(Pieza, Precio), Precios).

precio(codo(_), 5).

precio(canio(_, Metros), Precio) :-
    Precio is 3 * Metros.

precio(canilla(_, triangular, _), 20).

precio(canilla(_, _, Ancho), 12) :-
    Ancho <= 5.

precio(canilla(_, _, Ancho), 15) :-
    Ancho > 5.

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
puedoEnchufar(Pieza1, Pieza2) :-
    enchufan(Pieza1, Pieza2),
    enchufaAIzquierda(Pieza1, Pieza2).

enchufan(Pieza1, Pieza2) :-
    color(Pieza1, Color),
    color(Pieza2, Color).

enchufan(Pieza1, Pieza2) :-
    color(Pieza1, Color1),
    color(Pieza2, Color2),
    coloresEnchufables(Color1, Color2, _).

color(codo(Color), Color).

color(canio(Color, _), Color).

color(canilla(Color, _, _), Color).

coloresEnchufables(azul, rojo, izquierda).

coloresEnchufables(rojo, negro, izquierda).

enchufaAIzquierda(Pieza1, Pieza2) :-
    color(Pieza1, Color1),
    color(Pieza2, Color2),
    coloresEnchufables(Color1, Color2, izquierda).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
