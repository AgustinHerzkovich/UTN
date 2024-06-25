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
padreDe(bart,caca).
padreDe(bart,cas).

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

%%%%%%%%%%%%%%
%% Punto 01 %%
%%%%%%%%%%%%%%

tieneHijo(Progenitor):-
    padreDe(Progenitor,_).
tieneHijo(Progenitor):-
    madreDe(Progenitor,_).

hermanos(Hermano1,Hermano2):-
    padreDe(Padre,Hermano1),
    padreDe(Padre,Hermano2),
    madreDe(Madre,Hermano1),
    madreDe(Madre,Hermano2),
    Hermano1 \= Hermano2.

medioHermanos(Hermano1,Hermano2):-
    padreDe(Padre,Hermano1),
    padreDe(Padre,Hermano2),
    Hermano1 \= Hermano2.
medioHermanos(Hermano1,Hermano2):-
    madreDe(Madre,Hermano1),
    madreDe(Madre,Hermano2),
    Hermano1 \= Hermano2.

tioDe(Tio,Sobrino):-
    padreDe(Padre,Sobrino),
    hermanos(Tio,Padre).
tioDe(Tio,Sobrino):-
    madreDe(Madre,Sobrino),
    hermanos(Tio,Madre).

abueloMultiple(Abuelo):-
    padreDe(Abuelo,Hijo),
    padreDe(Hijo,Nieto1),
    padreDe(Hijo,Nieto2),
    Nieto1 \= Nieto2.
abueloMultiple(Abuelo):-
    padreDe(Abuelo,Hijo),
    madreDe(Hijo,Nieto1),
    madreDe(Hijo,Nieto2),
    Nieto1 \= Nieto2.
abueloMultiple(Abuelo):-
    madreDe(Abuelo,Hijo),
    padreDe(Hijo,Nieto1),
    padreDe(Hijo,Nieto2),
    Nieto1 \= Nieto2.
abueloMultiple(Abuelo):-
    madreDe(Abuelo,Hijo),
    madreDe(Hijo,Nieto1),
    madreDe(Hijo,Nieto2),
    Nieto1 \= Nieto2.

%%%%%%%%%%%%%%
%% Punto 02 %%
%%%%%%%%%%%%%%
abueloDe(Abuelo,Nieto):-
    padreDe(Abuelo,Hijo),
    padreDe(Hijo,Nieto).
abueloDe(Abuelo,Nieto):-
    madreDe(Abuelo,Hijo),
    padreDe(Hijo,Nieto).
abueloDe(Abuelo,Nieto):-
    padreDe(Abuelo,Hijo),
    madreDe(Hijo,Nieto).
abueloDe(Abuelo,Nieto):-
    madreDe(Abuelo,Hijo),
    madreDe(Hijo,Nieto).

descendiente(Ascendente,Descendiente):-
    padreDe(Ascendente,Descendiente).
descendiente(Ascendente,Descendiente):-
    madreDe(Ascendente,Descendiente).
descendiente(Ascendente,Descendiente):-
    tioDe(Ascendente,Descendiente).
descendiente(Ascendente,Descendiente):-
    abueloDe(Ascendente,Descendiente).