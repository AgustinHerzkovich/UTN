%%%%%%%%%%%%%%%%%%%%%%%%
% BaSe de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
%composicion(plato, [ingrediente])%
composicion(platoPrincipal(milanesa),[ingrediente(pan,3),ingrediente(huevo,2),ingrediente(carne,2)]).
composicion(entrada(ensMixta),[ingrediente(tomate,2),ingrediente(cebolla,1),ingrediente(lechuga,2)]).
composicion(entrada(ensFresca),[ingrediente(huevo,1),ingrediente(remolacha,2),ingrediente(zanahoria,1)]).
composicion(postre(budinDePan),[ingrediente(pan,2),ingrediente(caramelo,1)]).

%calorías(nombreIngrediente, cantidadCalorias)%
calorias(pan,30).
calorias(huevo,18).
calorias(carne,40).
calorias(caramelo,170).

%proveedor(nombreProveedor, [nombreIngredientes])%
proveedor(disco, [pan, caramelo, carne, cebolla]).
proveedor(sanIgnacio, [zanahoria, lechuga, miel, huevo]).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
caloriasTotal(Plato, Calorias) :-
    composicion(Plato, Ingredientes),
    caloriasIngredientes(Ingredientes, CaloriasIngredientes),
    sumlist(CaloriasIngredientes, Calorias).

caloriasIngredientes(Ingredientes, Calorias) :-
    findall(Caloria, (member(Ingrediente, Ingredientes), caloriasDeIngrediente(Ingrediente, Caloria)), Calorias).

caloriasDeIngrediente(ingrediente(Nombre, Cantidad), Calorias) :-
    calorias(Nombre, Caloria),
    Calorias is Cantidad * Caloria.

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
platoSimpatico(Plato) :-
    incluye(Plato, pan),
    incluye(Plato, huevo).
platoSimpatico(Plato) :-
    tieneMenosDe(Plato, 200).

incluye(Plato, Ingrediente) :-
    composicion(Plato, Ingredientes),
    member(ingrediente(Ingrediente, _), Ingredientes).

tieneMenosDe(Plato, Calorias) :-
    caloriasTotal(Plato, CaloriasTotales),
    CaloriasTotales < Calorias.

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
menuDiet(Plato1, Plato2, Plato3) :-
    entradaPlatoPrincipalYPostre(Plato1, Plato2, Plato3),
    caloriasTotal(Plato1, Total1),
    caloriasTotal(Plato2, Total2),
    caloriasTotal(Plato3, Total3),
    Total1 + Total2 + Total3 =< 450.

entradaPlatoPrincipalYPostre(entrada(_), platoPrincipal(_), postre(_)).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
tieneTodo(Proveedor, Plato) :-
    composicion(Plato, Ingredientes),
    proveedor(Proveedor, IngredientesProveidos),
    subconjunto(Ingredientes, IngredientesProveidos).

subconjunto([],_).
subconjunto([X|Xs],L):-
    sinElemento(X,L,L2),
    subconjunto(Xs,L2).

sinElemento(E,[E|Xs],Xs).
sinElemento(E,[X|Xs],[X|XsSinE]):-
sinElemento(E,Xs,XsSinE).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
ingredientePopular(Ingrediente) :-
    incluye(Plato1, Ingrediente),
    incluye(Plato2, Ingrediente),
    incluye(Plato3, Ingrediente),
    Plato1 \= Plato2,
    Plato1 \= Plato3,
    Plato2 \= Plato3.

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
cantidadTotal(Ingrediente, CantidadesPorPlato, Total) :-
    findall(CantidadUnidad, cantidadesPorUnidad(Ingrediente, CantidadesPorPlato, CantidadUnidad), Totales),
    sumlist(Totales, Total).

cantidadesPorUnidad(Ingrediente, CantidadesPorPlato, CantidadUnidad) :-
    member(cantidad(Plato, Cantidad), CantidadesPorPlato),
    composicion(Plato, Ingredientes),
    member(ingrediente(Ingrediente, CantidadIngrediente), Ingredientes),
    CantidadUnidad is Cantidad * CantidadIngrediente.

cantidadesPorUnidad(Ingrediente, CantidadesPorPlato, 0) :-
    member(cantidad(Plato, _), CantidadesPorPlato),
    composicion(Plato, _),
    not(incluye(Plato, Ingrediente)).

% Pregunta Adicional
/*
Consulta variables por los 3 platos
Consulta variable por 2 platos y el tercero consulta individual
Consulta individual por 2 platos y el tercero variable
Consulta individual por los 3 platos
*/