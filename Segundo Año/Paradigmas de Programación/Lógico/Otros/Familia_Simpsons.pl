% padreDe (padre,hijo).
padreDe(abe, abbie).
padreDe(abe, homero).
padreDe(abe, herbert).
padreDe(clancy, marge).
padreDe(clancy, patty).
padreDe(clancy, selma).
padreDe(homero, bart).
padreDe(homero, hugo).
padreDe(homero, lisa).
padreDe(homero, maggie).

%madreDe (madre,hijo).
madreDe(edwina, abbie).
madreDe(mona, homero).
madreDe(gaby, herbert).
madreDe(jacqueline, marge).
madreDe(jacqueline, patty).
madreDe(jacqueline, selma).
madreDe(marge, bart).
madreDe(marge, hugo).
madreDe(marge, lisa).
madreDe(marge, maggie).
madreDe(selma, ling).

pareja(abe,mona).
pareja(clancy,jacqueline).
pareja(homero,marge).

%%%%%%%%%%%%%%
%% Punto 01 %%
%%%%%%%%%%%%%%
% tieneHijo/1: Nos dice si un personaje tiene un hijo o hija.
tieneHijo(Progenitor):-
    padreDe(Progenitor,_).
tieneHijo(Progenitor):-
    madreDe(Progenitor,_).

% hermanos/2: Relaciona a dos personajes cuando estos comparten madre y padre.
compartenMadre(Hermano1,Hermano2):-
    madreDe(Madre,Hermano1),
    madreDe(Madre,Hermano2),
    Hermano1 \= Hermano2.

compartenPadre(Hermano1,Hermano2):-
    padreDe(Padre,Hermano1),
    padreDe(Padre,Hermano2),
    Hermano1 \= Hermano2.

hermanos(Hermano1,Hermano2):-
    compartenMadre(Hermano1,Hermano2),
    compartenPadre(Hermano1,Hermano2).

% medioHermanos/2: Relaciona a dos personajes cuando estos comparten madre o padre.
medioHermanos(Hermano1,Hermano2):-
    compartenMadre(Hermano1,Hermano2),
    not(compartenPadre(Hermano1,Hermano2)).
medioHermanos(Hermano1,Hermano2):-
    compartenPadre(Hermano1,Hermano2),
    not(compartenMadre(Hermano1,Hermano2)).

% tioDe/2: Relaciona a un personaje con su sobrino. Generalmente, también se le llama tío a la pareja del tío de sangre.
tioDeSangre(Tio,Sobrino):-
    padreDe(Padre,Sobrino),
    hermanos(Tio,Padre).
tioDeSangre(Tio,Sobrino):-
    madreDe(Madre,Sobrino),
    hermanos(Tio,Madre).

parejaDe(Persona1,Persona2):-
    pareja(Persona1,Persona2).
parejaDe(Persona1,Persona2):-
    pareja(Persona2,Persona1).

tioDe(Tio,Sobrino):-
    tioDeSangre(Tio,Sobrino).
tioDe(Tio,Sobrino):-
    tioDeSangre(TioOriginal,Sobrino),
    parejaDe(TioOriginal,Tio).

% abueloMultiple/1: Nos dice si alguien es abuelo de al menos dos nietos.
progenitor(Progenitor,Hijo):-
    padreDe(Progenitor,Hijo).
progenitor(Progenitor,Hijo):-
    madreDe(Progenitor,Hijo).

abueloDe(Abuelo,Nieto):-
    progenitor(Abuelo,Hijo),
    progenitor(Hijo,Nieto).

abueloMultiple(Abuelo):-
    abueloDe(Abuelo,Nieto1),
    abueloDe(Abuelo,Nieto2),
    Nieto1 \= Nieto2.

% Otros: cuñados/suegros/consuegros/yernos/nueras/primos
cuniados(Cuniado1,Cuniado2):-
    hermanos(Cuniado1,Hermano),
    parejaDe(Cuniado2,Hermano).

suegros(Suegro,Yerno):-
    parejaDe(Yerno,Pareja),
    progenitor(Suegro,Pareja).

consuegros(Consuegro,Conyerno):-
    progenitor(Conyerno,Hijo),
    suegros(Consuegro,Hijo).

yernoNuera(Yerno,Suegro):-
    suegros(Suegro,Yerno).

primos(Primo1,Primo2):-
    tioDe(Primo1,Tio),
    progenitor(Tio,Primo2).

%%%%%%%%%%%%%%
%% Punto 02 %%
%%%%%%%%%%%%%%
% descendiente/2: Relaciona a dos personajes, en donde uno desciende del otro a través de una cantidad no predeterminada de generaciones.
descendiente(Descendiente,Ancestro):-
    progenitor(Ancestro,Descendiente).
descendiente(Descendiente,Ancestro):-
    progenitor(Ancestro,Intermedio),
    descendiente(Descendiente,Intermedio).