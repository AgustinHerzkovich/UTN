%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% juego(Nombre, Género , Precio).
% functores de género: accion. rol(UsuariosActivos). puzzle(CantidadNiveles, Dificultad).
juego(gta, accion, 500).
juego(eldenRing, accion, 700).
juego(amongUs, rol(120000), 120).
juego(portal, puzzle(50, dificil), 100).
juego(minecraft, rol(20000000), 1000).
juego(counterStrike, accion, 1000).

% descuento(JuegoEnOferta, PorcentajeDescuento)
descuento(amongUs, 0.75).
descuento(eldenRing, 0.10).
descuento(counterStrike, 0.50).

% usuario(Nombre).
usuario(fede).
usuario(feli).

% posee(Usuario, Juego).
posee(feli, eldenRing).
posee(feli, gta).
posee(fede, amongUs).
posee(fede, portal).

% compraParaSiMismo(Usuario, Juego).
compraParaSiMismo(feli, minecraft).

% piensaRegalar(Usuario1, Usuario2, Juego).
piensaRegalar(fede, feli, counterStrike).
piensaRegalar(feli, fede, minecraft).

% planeaAdquirir(Usuario, Juego).
planeaAdquirir(Usuario, Juego) :-
    compraParaSiMismo(Usuario, Juego).
planeaAdquirir(Usuario, Juego) :-
    piensaRegalar(Usuario, _, Juego).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
% cuantoSale/2
cuantoSale(Juego, Precio) :-
    estaEnOferta(Juego),
    precioConDescuento(Juego, Precio).
cuantoSale(Juego, Precio) :-
    juego(Juego),
    not(estaEnOferta(Juego)),
    precioOriginal(Juego, Precio).

juego(Juego) :-
    juego(Juego, _, _).

estaEnOferta(Juego) :-
    descuento(Juego, _).

precioOriginal(Juego, Precio) :-
    juego(Juego, _, Precio).

precioConDescuento(Juego, Precio) :-
    precioOriginal(Juego, PrecioOriginal),
    descuento(Juego, Descuento),
    Precio is PrecioOriginal * (1 - Descuento).

% esPopular/1
esPopular(Juego) :-
    genero(Juego, Tipo),
    tipoPopular(Tipo).
esPopular(minecraft).
esPopular(counterStrike).

genero(Juego, Genero) :-
    juego(Juego, Genero, _).

tipoPopular(accion).
tipoPopular(rol(UsuariosActivos)) :-
    UsuariosActivos > 1000000.
tipoPopular(puzzle(_, facil)).
tipoPopular(puzzle(25, _)).
 
% adictoALosDescuentos/1
adictoALosDescuentos(Usuario) :-
    usuario(Usuario),
    forall(planeaAdquirir(Usuario, Juego), descuentoDeAlMenos(Juego, 0.5)).

descuentoDeAlMenos(Juego, DescuentoMinimo) :-
    descuento(Juego, Descuento),
    Descuento >= DescuentoMinimo.

% fanatico/2
fanatico(Usuario, Genero) :-
    posee(Usuario, Juego1),
    posee(Usuario, Juego2),
    Juego1 \= Juego2,
    mismoGenero(Juego1, Juego2, Genero).

mismoGenero(Juego1, Juego2, Genero) :-
    genero(Juego1, Genero),
    genero(Juego2, Genero).

% monotematico/2
monotematico(Usuario, Genero) :-
    usuario(Usuario),
    genero(_, Genero),
    forall(posee(Usuario, Juego), genero(Juego, Genero)).

% buenosAmigos/2
buenosAmigos(Usuario1, Usuario2) :-
    piensaRegalar(Usuario1, Usuario2, Juego1),
    piensaRegalar(Usuario2, Usuario1, Juego2),
    esPopular(Juego1),
    esPopular(Juego2).

% cuantoGastara/2
cuantoGastara(Usuario, Total) :-
    usuario(Usuario),
    findall(Gasto, gasta(Usuario, Gasto), Gastos),
    sumlist(Gastos, Total).

gasta(Usuario, Dinero) :-
    planeaAdquirir(Usuario, Juego),
    cuantoSale(Juego, Dinero).