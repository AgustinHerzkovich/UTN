%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
personaje(pumkin, ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent, mafioso(maton)).
personaje(jules, mafioso(maton)).
personaje(marsellus, mafioso(capo)).
personaje(winston, mafioso(resuelveProblemas)).
personaje(mia, actriz([foxForceFive])).
personaje(butch, boxeador).

pareja(marsellus, mia).
pareja(pumkin, honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

caracteristicas(vincent, [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules, [tieneCabeza, muchoPelo]).
caracteristicas(marvin, [negro]).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
esPeligroso(Personaje) :-
    realizaActividadPeligrosa(Personaje).
esPeligroso(Personaje) :-
    tieneEmpleadosPeligrosos(Personaje).

realizaActividadPeligrosa(Personaje) :-
    personaje(Personaje, Actividad),
    esPeligrosa(Actividad).

tieneEmpleadosPeligrosos(Personaje) :-
    trabajaPara(Personaje, Empleado),
    esPeligroso(Empleado).

esPeligrosa(mafioso(maton)).
esPeligrosa(ladron(Tiendas)) :-
    member(licorerias, Tiendas).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
duoPeligroso(Personaje1, Personaje2) :-
    esPeligroso(Personaje1),
    esPeligroso(Personaje2),
    duo(Personaje1, Personaje2).

duo(Personaje1, Personaje2) :-
    sonPareja(Personaje1, Personaje2).
duo(Personaje1, Personaje2) :-
    sonAmigos(Personaje1, Personaje2).

sonPareja(Personaje1, Personaje2) :-
    pareja(Personaje1, Personaje2).
sonPareja(Personaje1, Personaje2) :-
    pareja(Personaje2, Personaje1).

sonAmigos(Personaje1, Personaje2) :-
    amigo(Personaje1, Personaje2).
sonAmigos(Personaje1, Personaje2) :-
    amigo(Personaje2, Personaje1).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
estaEnProblemas(Personaje) :-
    trabajaPara(Jefe, Personaje),
    esPeligroso(Jefe),
    encargo(Jefe, Personaje, cuidar(Pareja)),
    sonPareja(Jefe, Pareja).
estaEnProblemas(Personaje) :-
    encargo(_, Personaje, buscar(Boxeador, _)),
    personaje(Boxeador, boxeador).
estaEnProblemas(butch).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
sanCayetano(Personaje) :-
    esPersonaje(Personaje),
    forall(tieneCerca(Personaje, PersonajeCercano), leDaTrabajo(Personaje, PersonajeCercano)).

tieneCerca(Personaje, OtroPersonaje) :-
    sonAmigos(Personaje, OtroPersonaje).
tieneCerca(Personaje, OtroPersonaje) :-
    tieneCerca(Personaje, OtroPersonaje),
    trabajaPara(Personaje, OtroPersonaje).

leDaTrabajo(Personaje, OtroPersonaje) :-
    encargo(Personaje, OtroPersonaje, _).

esPersonaje(Personaje) :-
    personaje(Personaje, _).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
masAtareado(Personaje) :-
    esPersonaje(Personaje),
    forall(esPersonaje(OtroPersonaje), tieneMasEncargos(Personaje, OtroPersonaje)).

tieneMasEncargos(Personaje, OtroPersonaje) :-
    cantidadEncargos(Personaje, Cantidad1),
    cantidadEncargos(OtroPersonaje, Cantidad2),
    Cantidad1 >= Cantidad2.

cantidadEncargos(Personaje, Cantidad) :-
    findall(Encargo, encargo(_, Personaje, Encargo), Encargos),
    length(Encargos, Cantidad).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
personajesRespetables(Personajes) :-
    findall(Personaje, esRespetable(Personaje),  Personajes).

esRespetable(Personaje) :-
    personaje(Personaje, Actividad),
    nivelDeRespeto(Actividad, Nivel),
    Nivel > 9.

nivelDeRespeto(actriz(Peliculas), Nivel) :-
    length(Peliculas, Cantidad),
    Nivel is Cantidad / 10.
nivelDeRespeto(mafioso(resuelveProblemas), 10).
nivelDeRespeto(mafioso(maton), 1).
nivelDeRespeto(mafioso(capo), 20).

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
hartoDe(Personaje1, Personaje2) :-
    esPersonaje(Personaje1),
    esPersonaje(Personaje2),
    forall(encargo(_, Personaje1, Tarea), requiereInteractuar(Personaje1, Personaje2, Tarea)).

requiereInteractuar(Personaje1, Personaje2, Tarea) :-
    cuidarBuscarOAyudar(Personaje1, Personaje2, Tarea).
requiereInteractuar(Personaje1, Personaje2, Tarea) :-
    sonAmigos(Amigo, Personaje2),
    cuidarBuscarOAyudar(Personaje1, Amigo, Tarea).

cuidarBuscarOAyudar(_, Personaje2, cuidar(Personaje2)).
cuidarBuscarOAyudar(_, Personaje2, buscar(Personaje2, _)).
cuidarBuscarOAyudar(_, Personaje2, ayudar(Personaje2)).

%%%%%%%%%%%%
% Punto 08 %
%%%%%%%%%%%%
duoDiferenciable(Personaje1, Personaje2) :-
    duo(Personaje1, Personaje2),
    difiereCaracteristica(Personaje1, Personaje2).

difiereCaracteristica(Personaje1, Personaje2) :-
    esPersonaje(Personaje2),
    tieneCaracteristica(Personaje1, Caracteristica),
    not(tieneCaracteristica(Personaje2, Caracteristica)).
difiereCaracteristica(Personaje1, Personaje2) :-
    difiereCaracteristica(Personaje2, Personaje1).

tieneCaracteristica(Personaje, Caracteristica) :-
    caracteristicas(Personaje, Caracteristicas),
    member(Caracteristica, Caracteristicas).