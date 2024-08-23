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

/* TODO
% b.
tareaAtrasada(_, prepararParcial(_)).
tareaAtrasada(Ayudante, Tarea) :-
    tarea(Ayudante, Tarea),
    atraso(Tarea, Atraso),
    Atraso > 3.

atraso(corregirTp(FechaEntrega, _, _), Atraso) :-
    Atraso is FechaEntrega + 4.
atraso(robarseBorrador(DiaDeLaClase, _), DiaDeLaClase).
*/
%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%