%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% a.
/*
todos siguen a un rey si todos los personajes siguen a ese rey.
*/

% b.
/*
4 cláusulas
2 predicados
todosSiguenA/1
sigueA/2
*/

% c.
/*
el not es innecesario, se reemplaza por un forall.
*/

% d.
todosSiguenA(Rey) :-
    personaje(Rey),
    forall(personaje(Personaje),sigueA(Personaje,Rey)).

% e.
/*
todosSiguenA: Sí
sigueA: Sí
*/

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
% a.
/*
una ciudad es interesante si esa ciudad es antigua y tiene más de 10 lugares copados.
un lugar es copado si es punto de interés en esa ciudad y opcionalmente otra condición.
*/

% b.
/*
4 cláusulas
4 predicados
baresCopados/2
museosCopados/2
estadiosCopados/2
ciudadInteresante/1
*/

% c.
/*
nombres poco declarativos para las características de los lugares.
las variables de los findall no se relacionan con nada.
lógica repetida para la cantidad de lugares copados.
*/

% d.
ciudadInteresante(Ciudad) :-
    antigua(Ciudad),
    cantidadLugaresCopados(Ciudad, Cantidad),
    Cantidad > 10.

cantidadLugaresCopados(Ciudad, Cantidad) :-
    findall(Lugar, lugarCopado(Lugar, Ciudad), LugaresCopados),
    length(LugaresCopados, Cantidad).

lugarCopado(Lugar, Ciudad) :-
    puntoDeInteres(Lugar, Ciudad),
    copado(Lugar).

copado(bar(CantidadVariablesCerveza)) :-
    CantidadVariablesCerveza > 4.

copado(museo(cienciasNaturales)).

copado(estadio(Capacidad)) :-
    Capacidad > 40000.

% e.
/*
baresCopados: No
museosCopados: No
estadiosCopados: No
ciudadInteresante: Sí
*/

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
% a.
/*
un delincuente es pillado inFraganti para cierto delito si ese delincuente cometió ese delito 
y fue visto por algún testigo.
*/

% b.
/*
1 cláusula
1 predicado
inFraganti/2
*/

% c.
/*
es innecesario fabricar una lista de testigos y verificar que su longitud sea mayor a 0, esto
se soluciona haciendo que por lo menos un testigo haya presenciado el delito.
*/

% d.
inFraganti(Delito, Delincuente) :-
    cometio(Delito, Delincuente),
    testigo(Delito, _).

% e.
/*
inFraganti: Sí
*/

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
% a.
/*
un pensador es viejoMaestro si para todo pensamiento de ese pensador, el pensamiento
llega a nuestros días.
*/

% b.
/*
1 cláusula
1 predicado
viejoMaestro/1
*/

% c.
/*
Pensador no está unificado previo al forall.
*/

% d.
viejoMaestro(Pensador) :-
    pensamiento(Pensador, _),
    forall(pensamiento(Pensador, Pensamiento), llegaANuestrosDias(Pensamiento)).

% e.
/*
viejoMaestro: No
*/

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
% a.
/*
el número de la suerte de una persona es aquel que se corresponde con el día de su nacimiento,
para joaquin su número de la suerte es 2.
*/

% b.
/*
2 cláusulas
1 predicado
numeroDeLaSuerte/2
*/

% c.
/*
el is es utilizado de manera incorrecta, únicamente se debe utilizar cuando a la derecha
del is hay una operación aritmética.
*/

% d.
numeroDeLaSuerte(Persona, Numero) :-
    diaDelNacimiento(Persona, Numero).

numeroDeLaSuerte(joaquin, 2).

% e.
/*
numeroDeLaSuerte: Sí
*/

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
% a.
/*
una obra es considerada obra maestra para cierto compositor si fue compuesta por este y
todo movimiento de esa obra cumple las condiciones.
*/

% b.
/*
1 cláusula
1 predicado
obraMaestra/2
*/

% c.
/*
el nombre cumpleCondiciones no es expresivo.
*/

% d.
obraMaestra(Compositor, Obra) :-
    compositor(Compositor, Obra),
    forall(movimiento(Obra, Movimiento), superMovimiento(Movimiento)).

% e.
/*
obraMaestra: Sí
*/

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
% a.
/*
analia puede comer una comida si esta posee únicamente ingredientes veganos.
evaristo puede comer asado.
*/

% b.
/*
2 cláusulas
1 predicado
puedeComer/2
*/

% c.
/*
la condición del forall se puede delegar para que el ingrediente sea vegano.
*/

% d.
puedeComer(analia, Comida): -
    ingrediente(Comida, _),
    forall(ingrediente(Comida, Ingrediente), ingredienteVegano(Ingrediente)).

puedeComer(evaristo, asado).

ingredienteVegano(Ingrediente) :-
    ingrediente(_, Ingrediente),
    not(contieneCarne(Ingrediente), contieneHuevo(Ingrediente), contieneLeche(Ingrediente)).

% e.
/*
puedeComer: Sí
*/

%%%%%%%%%%%%
% Punto 08 %
%%%%%%%%%%%%
% a.
/*
el costo de envió de un paquete es igual la suma de todos los precios de item de ese paquete.
*/

% b.
/*
4 cláusulas
2 predicados
costoEnvio/2
precioItemPaquete/2
*/

% c.
/*
se repite la lógica para el precio del paquete.
*/

% d.
costoEnvio(Paquete, PrecioTotal) :-
    itemPaquete(Paquete, _),
    findall(PrecioItem, precioItemPaquete(Paquete, PrecioItem), Precios),
    sumlist(Precios, PrecioTotal).    

precioItemPaquete(Paquete, Precio) :-
    itemPaquete(Paquete, Item),
    precioItem(Item, Precio).

precioItem(libro(Precio), Precio).

precioItem(mp3(_, Duracion), Precio) :-
    Precio is Duracion * 0.42.

precioItem(productoEnOferta(_, PrecioOferta), PrecioOferta).

% e.
/*
costoEnvio: No
precioItemPaquete: Sí
*/