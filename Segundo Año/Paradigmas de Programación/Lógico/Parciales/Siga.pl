%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
%Días de cursadas (toda materia que se dicte ofrece al menos una opción horaria)
opcionHoraria(paradigmas, lunes).
opcionHoraria(paradigmas, martes).
opcionHoraria(paradigmas, sabados).
opcionHoraria(algebra, lunes).

%Correlatividades
correlativa(paradigmas, algoritmos).
correlativa(paradigmas, algebra).
correlativa(analisis2, analisis1).

%cursada(persona,materia,evaluaciones)
cursada(maria,algoritmos,[parcial(5),parcial(7),tp(mundial,bien)]).
cursada(maria,algebra,[parcial(5),parcial(8),tp(geometria,excelente)]).
cursada(maria,analisis1,[parcial(9),parcial(4),tp(gauss,bien), tp(limite,mal)]).
cursada(wilfredo,paradigmas,[parcial(7),parcial(7),parcial(7),tp(objetos,excelente),tp(logico,excelente),tp(funcional,excelente)]).
cursada(wilfredo,analisis2,[parcial(8),parcial(10)]).

%%%%%%%%%%%%
% Ayuditas %
%%%%%%%%%%%%
subconjunto([],_).
subconjunto([X|Xs],L):-
    sinElemento(X,L,L2),
    subconjunto(Xs,L2).

sinElemento(E,[E|Xs],Xs).
sinElemento(E,[X|Xs],[X|XsSinE]):-
sinElemento(E,Xs,XsSinE).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
notaFinal(Evaluaciones, NotaFinal) :-
    findall(NotaEvaluacion, notaEvaluacion(Evaluaciones, NotaEvaluacion), Notas),
    promedio(Notas, NotaFinal).

notaEvaluacion(Evaluaciones, NotaEvaluacion) :-
    member(Evaluacion, Evaluaciones),
    nota(Evaluacion, NotaEvaluacion).

promedio(Notas, NotaFinal) :-
    length(Notas, CantidadNotas),
    sumlist(Notas, TotalNotas),
    NotaFinal is TotalNotas / CantidadNotas.

nota(parcial(Nota), Nota).
nota(tp(_, NotaTp), Nota) :-
    notaTp(NotaTp, Nota).

notaTp(excelente, 10).
notaTp(bien, 7).
notaTp(mal, 2).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
aprobo(Persona, Materia) :-
    cursada(Persona, Materia, Evaluaciones),
    aproboFinal(Evaluaciones),
    aproboIndividualmente(Evaluaciones).

aproboFinal(Evaluaciones) :-
    notaFinal(Evaluaciones, NotaFinal),
    notaAprobada(NotaFinal).

aproboIndividualmente(Evaluaciones) :-
    forall(member(Evaluacion, Evaluaciones), evaluacionAprobada(Evaluacion)).

evaluacionAprobada(Evaluacion) :-
    nota(Evaluacion, Nota),
    notaAprobada(Nota).

notaAprobada(Nota) :-
    Nota >= 4.

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
puedeCursar(Alumno, Materia) :-
    alumno(Alumno),
    materia(Materia),
    not(aprobo(Alumno, Materia)),
    aproboCorrelativas(Alumno, Materia).
puedeCursar(_, Materia) :-
    not(correlativa(Materia, _)).

alumno(Alumno) :-
    cursada(Alumno, _, _).

materia(Materia) :-
    opcionHoraria(Materia, _).
materia(Materia) :-
    correlativa(Materia, _).
materia(Materia) :-
    correlativa(_, Materia).
materia(Materia) :-
    cursada(_, Materia, _).

aproboCorrelativas(Alumno, Materia) :-
    forall(correlativa(Materia, Correlativa), aprobo(Alumno, Correlativa)).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
cuatrimestrePosible(Alumno, Opciones) :-
    alumno(Alumno),
    findall(OpcionDeCursada, opcionDeCursada(Alumno, OpcionDeCursada), Opciones).

opcionDeCursada(Alumno, opcion(Materia, Dia)) :-
    distinct((Materia, Dia),
        (
            puedeCursar(Alumno, Materia),
            opcionHoraria(Materia, Dia)
        )
    ).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
sinSuperposiciones(Opciones, OpcionesDeCursada) :-
    subconjunto(OpcionesDeCursada, Opciones),
    conformaUnaCursada(OpcionesDeCursada).

conformaUnaCursada(Opciones) :-
    forall(distintosMiembros(Opcion1, Opcion2, Opciones), noRepite(Opcion1, Opcion2)).
distintosMiembros(Opcion1, Opcion2, Opciones) :-
    member(Opcion1, Opciones), 
    member(Opcion2, Opciones), 
    Opcion1 \= Opcion2.

noRepite(opcion(Materia1, Dia1), opcion(Materia2, Dia2)) :-
    Materia1 \= Materia2,
    Dia1 \= Dia2.