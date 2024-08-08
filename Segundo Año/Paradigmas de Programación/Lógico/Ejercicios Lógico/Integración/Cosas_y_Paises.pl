tarea(basico,buscar(libro,jartum)).
tarea(basico,buscar(arbol,patras)).
tarea(basico,buscar(roca,telaviv)).
tarea(intermedio,buscar(arbol,sofia)).
tarea(intermedio,buscar(arbol,bucarest)).
tarea(avanzado,buscar(perro,bari)).
tarea(avanzado,buscar(flor,belgrado)).

nivelActual(pepe,basico).
nivelActual(lucy,intermedio).
nivelActual(juancho,avanzado).

idioma(alejandria,arabe).
idioma(jartum,arabe).
idioma(patras,griego).
idioma(telaviv,hebreo).
idioma(sofia,bulgaro).
idioma(bari,italiano).
idioma(bucarest,rumano).
idioma(belgrado,serbio).

habla(pepe,bulgaro).
habla(pepe,griego).
habla(pepe,italiano).
habla(juancho,arabe).
habla(juancho,griego).
habla(juancho,hebreo).
habla(lucy,griego).

capital(pepe,1200).
capital(lucy,3000).
capital(juancho,500).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
destinoPosible(Nivel, Ciudad) :-
    tarea(Nivel, buscar(_, Ciudad)).

idiomaUtil(Nivel, Idioma) :-
    destinoPosible(Nivel, Destino),
    idioma(Destino, Idioma).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
excelenteCompaniero(Participante1, Participante2) :-
    nivelActual(Participante1, Nivel),
    participante(Participante2),
    forall(idiomaUtil(Nivel, Idioma), habla(Participante2, Idioma)).

participante(Participante) :-
    nivelActual(Participante, _).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
interesante(Nivel) :-
    nivel(Nivel),
    forall(busquedaPosible(Nivel, Cosa), estaViva(Cosa)).

interesante(Nivel) :-
    destinoPosible(Nivel, Destino),
    idioma(Destino, italiano).

interesante(Nivel) :-
    participantes(Nivel, Participantes),
    capitales(Participantes, Capitales),
    sumlist(Capitales, Total),
    Total > 10000.

nivel(Nivel) :-
    nivelActual(_, Nivel).

busquedaPosible(Nivel, Cosa) :-
    tarea(Nivel, buscar(Cosa, _)).

estaViva(arbol).
estaViva(perro).
estaViva(flor).

participantes(Nivel, Participantes) :-
    findall(Participante, nivelActual(Nivel, Participante), Participantes).

capitales(Participantes, Capitales) :-
    findall(Capital, capitalPosible(Participantes, Capital), Capitales).

capitalPosible(Participantes, Capital) :-
    capital(Participante, Capital),
    member(Participante, Participantes).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
complicado(Participante) :-
    nivelActual(Participante, Nivel),
    forall(idiomaUtil(Nivel, Idioma), (not(habla(Idioma, Participante)))).

complicado(Participante) :-
    nivelActual(Participante, Nivel),
    Nivel \= basico,
    capital(Participante, Capital),
    Capital < 1500.

complicado(Participante) :-
    nivelActual(Participante, basico),
    capital(Participante, Capital),
    Capital < 500.

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
homogeneo(Nivel) :-
    nivel(Nivel),
    findall(CosaABuscar, tarea(Nivel , buscar(CosaABuscar, _)), CosasABuscar),
    unicoElemento(CosasABuscar).

distintoElemento(Lista) :-
    member(Miembro1, Lista),
    member(Miembro2, Lista),
    Miembro1 \= Miembro2.

unicoElemento(Lista) :-
    not(distintoElemento(Lista)).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
poliglota(Participante) :-
    participante(Participante),
    findall(Idioma, habla(Participante, Idioma), Idiomas),
    length(Idiomas, CantidadIdiomas),
    CantidadIdiomas >= 3.