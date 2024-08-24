%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%

% Las tareas son functores de la forma
% corregirTp(fechaEnQueElGrupoEntrego, grupo, paradigma)
% robarseBorrador(diaDeLaClase, horario)
% prepararParcial(paradigma).
tarea(vero, corregirTp(190, losMagiosDeTempeley, funcional)).
tarea(hernan, corregirTp(181, analiaAnalia, objetos)).
tarea(hernan, robarseBorrador(197, turnoManiana)).
tarea(hernan, prepararParcial(objetos)).
tarea(alf, prepararParcial(funcional)).
tarea(nitu, corregirTp(190, analiaAnalia, funcional)).
tarea(ignacio, corregirTp(186, laTerceraEsLaVencida, logico)).
tarea(clara, robarseBorrador(197, turnoNoche)).
tarea(hugo, corregirTp(10, laTerceraEsLaVencida, objetos)).
tarea(hugo, robarseBorrador(11, turnoNoche)).

% Estos grupos están en problemas
noCazaUna(loMagiosDeTempeley).
noCazaUna(losExDePepita).

% El 1 es el primero de enero, el 32 es el 1 de febrero, etc
diaDelAnioActual(192).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% a.
esDificil(robarseBorrador(_, turnoNoche)).
esDificil(corregirTp(_, _, objetos)).
esDificil(corregirTp(_, Grupo, _)) :-
    noCazaUna(Grupo).
esDificil(prepararParcial(_)).

% b.
tareaAtrasada(Ayudante, Tarea) :-
    tarea(Ayudante, Tarea),
    seAtrasa(Tarea).

seAtrasa(prepararParcial(_)).
seAtrasa(Tarea) :-
    diaDelAnioActual(FechaActual),
    fechaVencimiento(Tarea, FechaVencimiento),
    FechaActual > FechaVencimiento.

fechaVencimiento(corregirTp(FechaEntrega, _, _), FechaVencimiento) :-
    FechaVencimiento is FechaEntrega + 4.
fechaVencimiento(robarseBorrador(FechaVencimiento, _), FechaVencimiento).

% c.
verdugos(Grupo, Ayudantes) :-
    grupo(Grupo),
    findall(Ayudante, corrigioElTpDe(Grupo, Ayudante), Ayudantes).

grupo(Grupo) :-
    tarea(_, corregirTp(_, Grupo, _)).

corrigioElTpDe(Grupo, Ayudante) :-
    tarea(Ayudante, corregirTp(_, Grupo, _)).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
% Nueva info %
laburaEnProyectoEnLLamas(alf).
laburaEnProyectoEnLLamas(hugo).

cursa(nitu, [operativos, disenio, analisisMatematico2]).
cursa(clara, [sintaxis, operativos]).
cursa(ignacio, [tacs, administracionDeRecursos] ).

tienePareja(nitu).
tienePareja(alf).

% a.
tieneProblemitas(Ayudante) :-
    tienePareja(Ayudante).
tieneProblemitas(Ayudante) :-
    laburaEnProyectoEnLLamas(Ayudante).
tieneProblemitas(Ayudante) :-
    cursaOperativos(Ayudante).

cursaOperativos(Ayudante) :-
    cursa(Ayudante, Materias),
    member(operativos, Materias).
  
% b.
alHorno(Ayudante) :-
    tieneProblemitas(Ayudante),
    estaAtrasado(Ayudante),
    todasTareasDificiles(Ayudante).

estaAtrasado(Ayudante) :-
    tareaAtrasada(Ayudante, _).

todasTareasDificiles(Ayudante) :-
    ayudante(Ayudante),
    forall(tarea(Ayudante, Tarea), esDificil(Tarea)).

ayudante(Ayudante) :-
    tarea(Ayudante, _).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
% a.
/*
false. dado que para que se cumpla tareaAtrasada, el ayudante debe haber realizado
dicha tarea.
Se relaciona con el concepto de universo cerrado, ya que al no estar definida la cláusula
tarea para franco, se considera false el hecho de que franco llevó a cabo alguna tarea, por consiguiente,
no se cumple la primer condición para que la tarea esté atrasada.
*/

% b.
/*
en los predicados 'esDificil/1' y 'seAtrasa/1' ya que las tareas tienen distinta forma, y son representadas
mediante functores con distinto nombre y aridad.
*/

% c.
/*
Afirmativo, ya que los predicados que se deben cumplir para que estos sean verdaderos son inversibles.
En su mayoría son reglas, o predicados que ya fueron inversibilizados previamente como 'estaAtrasado/1' y
'todasTareasDificiles/1', donde sus potenciales problemas de inversibilidad fueron solucionados con anterior
ligando la variable Ayudante.
*/