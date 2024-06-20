gusta(brenda,fideos).
gusta(juan,maria).
gusta(pedro,ana).
gusta(pedro,nora).
gusta(Persona,zulema):-
    gusta(Persona,nora).
gusta(julian,Chica):-
    chica(Chica), morocha(Chica).
gusta(julian,Chica):-
    chica(Chica), conOnda(Chica).
gusta(mario,Chica):-
    chica(Chica), morocha(Chica), conOnda(Chica).
gusta(mario,luisa).

% con "y"
gusta(Persona,laura):-
    gusta(Persona,ana), gusta(Persona,luisa).

% con "o"
gusta(Persona,laura):-
    gusta(Persona,ana).

gusta(Persona,laura):-  
    gusta(Persona,luisa).