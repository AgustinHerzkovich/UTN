%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% atiende(Profesor, Día, HoraInicial, HoraFinal).
atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabados, 18, 22).
atiende(juanC, domingos, 18, 22).
atiende(juanFds, jueves, 10, 20).
atiende(juanFds, viernes, 12, 20).
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).
atiende(martu, miercoles, 23, 24).
atiende(vale, Dia, HoraInicial, HoraFinal) :-
    atiende(dodain, Dia, HoraInicial, HoraFinal).
atiende(vale, Dia, HoraInicial, HoraFinal) :-
    atiende(juanC, Dia, HoraInicial, HoraFinal).

/*
No es necesario agregar una cláusula de que nadie hace el mismo horario que leoC,
ya que por principio de universo cerrado, al no estar definida, la respuesta a si alguien
hace el mismo horario que leoC ya será false para cualquier profesor.

No es necesario agregar una cláusula para maiu ya que aún no tiene decidido en qué horario hacerlo,
nuevamente por principio de universo cerrado, lo desconocido es falso.
*/

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
atiendeEnFecha(Persona, Dia, Hora) :-
    atiende(Persona, Dia, HoraInicial, HoraFinal),
    between(HoraInicial, HoraFinal, Hora).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
foreverAlone(Persona, Dia, Hora) :-
    atiendeEnFecha(Persona, Dia, Hora),
    not(atiendeOtraPersona(Persona, Dia, Hora)).

atiendeOtraPersona(Persona, Dia, Hora) :-
    persona(OtraPersona),
    Persona \= OtraPersona,
    atiendeEnFecha(OtraPersona, Dia, Hora).

persona(Persona) :-
    atiende(Persona, _, _, _).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
puedeAtender(Personas, Dia) :-
    findall(Persona, atiendeEnFecha(Persona, Dia, _), PersonasTotales),
    combinaciones(PersonasTotales, Personas).

combinaciones([], []).
combinaciones([_ | Resto], Combinacion) :-
    combinaciones(Resto, Combinacion).
combinaciones([Cabeza | Resto], [Cabeza | Combinacion]) :-
    combinaciones(Resto, Combinacion).

% - findall como herramienta para poder generar un conjunto de soluciones que satisfacen un predicado
% - mecanismo de backtracking de Prolog permite encontrar todas las soluciones posibles

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
% vendio(Profesor, Día, [Venta]).
vendio(dodain, lunes10Agosto, [golosinas(1200), cigarrillos([jockey]), golosinas(50)]).
vendio(dodain, miercoles12Agosto, [bebidas(alcoholicas, 8), bebidas(noAlcoholicas, 1), golosinas(10)]).
vendio(martu, miercoles12Agosto, [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
vendio(lucas, martes11Agosto, [golosinas(600)]).
vendio(lucas, martes18Agosto, [bebidas(noAlcoholicas, 2), cigarrillos([derby])]).

suertudo(Vendedor) :-
    vendio(Vendedor, _, _),
    forall(ventaRealizada(Vendedor, Ventas), primeraVentaImportante(Ventas)).
suertudo(martu).
suertudo(dodain).

ventaRealizada(Vendedor, Ventas) :-
    vendio(Vendedor, _, Ventas).

primeraVentaImportante(Ventas) :-
    nth1(1, Ventas, Venta),
    importante(Venta).

importante(golosinas(100)).
importante(cigarrillos(Marcas)) :-
    length(Marcas, Cantidad),
    Cantidad > 2.
importante(bebidas(alcoholicas, _)).
importante(bebidas(_, Cantidad)) :-
    Cantidad > 5.