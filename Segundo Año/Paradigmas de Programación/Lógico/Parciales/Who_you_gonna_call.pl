%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

cazafantasma(egon).
cazafantasma(peter).
cazafantasma(ray).
cazafantasma(winston).

/*
- tareaPedida/3: relaciona al cliente, con la tarea pedida y la cantidad de metros cuadrados sobre los cuales hay que realizar esa tarea.
- precio/2: relaciona una tarea con el precio por metro cuadrado que se cobraría al cliente.
*/

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% a.
tieneHerramienta(egon, aspiradora(200)).

% b.
tieneHerramienta(egon, trapeador).
tieneHerramienta(peter, trapeador).

% c.
tieneHerramienta(winston, varitaDeNeutrones).

% d.
% no se agrega cláusula por principio de universo cerrado.

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
satisfaceNecesidad(Integrante, Herramienta) :-
    tieneHerramienta(Integrante, UnaHerramienta),
    cumpleHerramienta(UnaHerramienta, Herramienta).

cumpleHerramienta(Herramienta, Herramienta).
cumpleHerramienta(aspiradora(Nivelmayor), aspiradora(Nivelmenor)) :-
    Nivelmayor > Nivelmenor.

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
puedeRealizar(Integrante, Tarea) :-
    tieneHerramienta(Integrante, varitaDeNeutrones),
    tarea(Tarea).
puedeRealizar(Integrante, Tarea) :-
    cazafantasma(Integrante),
    herramientasRequeridas(Tarea, Herramientas),
    forall(member(Herramienta, Herramientas), satisfaceNecesidad(Integrante, Herramienta)).

tarea(Tarea) :-
    herramientasRequeridas(Tarea, _).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
cuantoCobrar(Cliente, Pedido, Total) :-
    precioTareaDePedido(Cliente, Pedido, _),
    findall(Precio, precioTareaDePedido(Cliente, Pedido, Precio), Precios),
    sumlist(Precios, Total).

precioTareaDePedido(Cliente, Pedido, Precio) :-
    member(Tarea, Pedido),
    tareaPedida(Cliente, Tarea, MetrosCuadrados),
    precio(Tarea, PrecioPorMetroCuadrado),
    Precio is PrecioPorMetroCuadrado * MetrosCuadrados.

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
quienesAceptan(Persona, Pedido) :-
    cazafantasma(Persona),
    forall(member(Tarea, Pedido), puedeRealizar(Persona, Tarea)),
    estaDispuestoAHacerlo(Persona, Pedido).

estaDispuestoAHacerlo(ray, Pedido) :-
    not(member(limpiarTecho, Pedido)).
estaDispuestoAHacerlo(winston, Pedido) :-
    cuantoCobrar(_, Pedido, Total),
    Total > 500.
estaDispuestoAHacerlo(egon, Pedido) :-
    forall(member(Tarea, Pedido), not(esCompleja(Tarea))).
estaDispuestoAHacerlo(peter, _).

esCompleja(Tarea) :-
    herramientasRequeridas(Tarea, Herramientas),
    length(Herramientas, Cantidad),
    Cantidad > 2.
esCompleja(limpiarTecho).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
% a.
% herramientasRequeridas(ordenarCuarto, [reemplazable([aspiradora(100), escoba]), trapeador, plumero]).

% b.
/*
Agregar la siguiente cláusula:
satisfaceNecesidad(Integrante, reemplazable(HerramientasAlternativas)) :-
    member(Herramienta, HerramientasAlternativas),
    satisfaceNecesidad(Integrante, Herramienta).
*/

% c.
/*
Agregar herramientas reemplazables es relativamente fácil porque estamos extendiendo la lógica de satisfaceNecesidad/2 
para manejar listas de alternativas. El uso de member/2 facilita verificar si al menos una opción en las herramientas reemplazables 
es satisfecha por el cazafantasma. Esta modificación no requiere cambios drásticos en los predicados ya existentes, sino solo una 
extensión de su lógica para manejar un nuevo tipo de entrada.
*/