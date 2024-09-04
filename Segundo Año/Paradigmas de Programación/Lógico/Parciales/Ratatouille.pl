%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%

rata(remy, gusteaus).
rata(emile, bar).
rata(django, pizzeria).

cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).

trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, skinner).
trabajaEn(gusteaus, horst).
trabajaEn(cafeDes2Moulins, amelie).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%

inspeccionSatisfactoria(Restaurante) :-
	restaurante(Restaurante),
	not(viveUnaRata(Restaurante)).

restaurante(Restaurante) :-
	trabajaEn(_, Restaurante).

viveUnaRata(Restaurante) :-
	rata(_, Restaurante).


%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
chef(Empleado, Restaurante) :-
	trabajaEn(Restaurante, Empleado),
	sabeCocinar(Empleado).

sabeCocinar(Empleado) :-
	cocina(Empleado, _, _).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
chefcito(Rata) :-
	rata(Rata, Restaurante),
	trabajaEn(Restaurante, linguini).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
cocinaBien(Persona, Plato):-
	cocina(Persona, Plato, Experiencia),
	Experiencia > 7.
cocinaBien(remy, _).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
encargadoDe(Encargado, Plato, Restaurante) :-
	trabajaEn(Restaurante, Encargado),
	plato(Plato),
	forall(trabajaEn(Restaurante, OtroEencargado), tieneMasExperiencia(Encargado, OtroEencargado, Plato)).

tieneMasExperiencia(Persona1, Persona2, Plato) :-
	cocina(Persona1, Plato, Experiencia1),
	cocina(Persona2, Plato, Experiencia2),
	Experiencia1 >= Experiencia2.

plato(Plato) :-
	cocina(_, Plato, _).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).

saludable(Plato) :-
	calorias(Plato, Calorias),
	Calorias < 75.
saludable(Plato) :-
	plato(Plato, postre(_)),
	grupo(Plato).

calorias(Plato, Calorias) :-
	plato(Plato, entrada(Ingredientes)),
	length(Ingredientes, Cantidad),
	Calorias is Cantidad * 15.
calorias(Plato, Calorias) :-
	plato(Plato, principal(Guarnicion, MinutosCoccion)),
	agregadoPorGuarnicion(Guarnicion, Agregado),
	Calorias is Agregado + (5 * MinutosCoccion).
calorias(Plato, Calorias) :-
	plato(Plato, postre(Calorias)).

agregadoPorGuarnicion(papasFritas, 50).
agregadoPorGuarnicion(pure, 20).
agregadoPorGuarnicion(ensalada, 0).

grupo(chocotorta).
grupo(mousseDeDulceDeLeche).
grupo(losPollosHermanos).

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
criticaPositiva(Restaurante, Critico) :-
	inspeccionSatisfactoria(Restaurante),
	satisface(Restaurante, Critico).

satisface(Restaurante, antonEgo) :-
	especialista(Restaurante, ratatouille).
satisface(Restaurante, christophe) :-
	tieneMasDeNChefs(Restaurante, 3).
satisface(Restaurante, cormillot) :-
	forall(platoDeRestaurante(Restaurante, Plato), saludableConZanahoria(Plato)).

especialista(Restaurante, Plato) :-
	plato(Plato),
	forall(chef(Empleado, Restaurante), cocinaBien(Empleado, Plato)). 

tieneMasDeNChefs(Restaurante, N) :-
	findall(Chef, chef(Chef, Restaurante), Chefs),
	length(Chefs, Cantidad),
	Cantidad > N.

platoDeRestaurante(Restaurante, Plato) :-
	trabajaEn(Restaurante, Empleado),
	cocina(Empleado, Plato, _).

saludableConZanahoria(Plato) :-
	saludable(Plato),
	not(plato(Plato, entrada(_))).
saludableConZanahoria(Plato) :-
	saludable(Plato),
	plato(Plato, entrada(Ingredientes)),
	member(zanahoria, Ingredientes).	