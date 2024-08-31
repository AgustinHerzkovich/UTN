%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
% canta(Vocaloid, canción(Nombre, Duración)).
canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).

% concierto(Nombre, País, Fama, Tipo).
% tipo: gigante(CantidadMínimaCanciones, DuraciónMínima). mediano(DuraciónMáxima). pequenio(DuraciónMínima).
concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisiones, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).

% conoce(UnVocaloid, OtroVocaloid).
conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
esNovedoso(Vocaloid) :-
    sabeAlMenosDosCanciones(Vocaloid),
    tiempoTotalCanciones(Vocaloid, Tiempo),
    Tiempo < 15.

sabeAlMenosDosCanciones(Vocaloid) :-
    canta(Vocaloid, Cancion1),
    canta(Vocaloid, Cancion2),
    Cancion1 \= Cancion2.

tiempoTotalCanciones(Vocaloid, TiempoTotal) :-
    findall(TiempoCancion, tiempoDeCanto(Vocaloid, TiempoCancion), Tiempos),
    sumlist(Tiempos, TiempoTotal).

tiempoDeCanto(Vocaloid, Tiempo) :-
    canta(Vocaloid, Cancion),
    duracionCancion(Cancion, Tiempo).

duracionCancion(cancion(_, Tiempo), Tiempo).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
acelerado(Vocaloid) :-
    vocaloid(Vocaloid),
    not(cantaCancionLarga(Vocaloid)).

cantaCancionLarga(Vocaloid) :-
    canta(Vocaloid, Cancion),
    larga(Cancion).

larga(Cancion) :-
    duracionCancion(Cancion, Tiempo),
    Tiempo > 4.

vocaloid(Vocaloid) :-
    canta(Vocaloid, _).
%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
puedeParticipar(Vocaloid, Concierto) :-
    requisitos(Concierto, Requisitos),
    cumpleRequisitos(Vocaloid, Requisitos).
puedeParticipar(hatsuneMiku, Concierto) :-
    concierto(Concierto, _, _, _).

requisitos(Concierto, Requisitos) :-
    concierto(Concierto, _, _, Requisitos).

cumpleRequisitos(Vocaloid, gigante(CantidadMinimaCanciones, DuracionMinima)) :-
    cuantasCancionesSabe(Vocaloid, Cantidad),
    Cantidad >= CantidadMinimaCanciones,
    tiempoTotalCanciones(Vocaloid, TiempoTotal),
    TiempoTotal > DuracionMinima.
cumpleRequisitos(Vocaloid, mediano(DuracionMaxima)) :-
    vocaloid(Vocaloid),
    forall(canta(Vocaloid, Cancion), duraMenosDe(Cancion, DuracionMaxima)).
cumpleRequisitos(Vocaloid, pequenio(DuracionMinima)) :-
    canta(Vocaloid, Cancion),
    duraMasDe(Cancion, DuracionMinima).

duraMenosDe(Cancion, DuracionMaxima) :-
    duracionCancion(Cancion, Duracion),
    Duracion < DuracionMaxima.

duraMasDe(Cancion, DuracionMinima) :-
    duracionCancion(Cancion, Duracion),
    Duracion > DuracionMinima.

cuantasCancionesSabe(Vocaloid, Cantidad) :-
    vocaloid(Vocaloid),
    findall(Cancion, canta(Vocaloid, Cancion), Canciones),
    length(Canciones, Cantidad).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
masFamoso(Vocaloid) :-
    vocaloid(Vocaloid),
    forall(vocaloidDistinto(Vocaloid, OtroVocaloid), tieneMasFama(Vocaloid, OtroVocaloid)).

vocaloidDistinto(Vocaloid, OtroVocaloid) :-
    vocaloid(Vocaloid),
    vocaloid(OtroVocaloid),
    Vocaloid \= OtroVocaloid.

tieneMasFama(Vocaloid, OtroVocaloid) :-
    fama(Vocaloid, Fama1),
    fama(OtroVocaloid, Fama2),
    Fama1 > Fama2.

fama(Vocaloid, Fama) :-
    famaTotalDeConciertosParticipes(Vocaloid, FamaConciertos),
    cuantasCancionesSabe(Vocaloid, CantidadCanciones),
    Fama is FamaConciertos * CantidadCanciones.

famaTotalDeConciertosParticipes(Vocaloid, Fama) :-
    findall(FamaConcierto, otorgaFamaConcierto(Vocaloid, FamaConcierto), TotalFamas),
    sumlist(TotalFamas, Fama).

otorgaFamaConcierto(Vocaloid, Fama) :-
    puedeParticipar(Vocaloid, Concierto),
    famaConcierto(Concierto, Fama).

famaConcierto(Concierto, Fama) :-
    concierto(Concierto, _, Fama, _).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
unicoParticipante(Vocaloid, Concierto) :-
    vocaloid(Vocaloid),
    forall(conocido(Vocaloid, Conocido), not(puedeParticipar(Conocido, Concierto))).

conocido(Alguien, Conocido) :-
    conoce(Alguien, Conocido).
conocido(Alguien, Conocido) :-
    conoce(Alguien, Intermedio),
    conocido(Intermedio, Conocido).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
/*
Si aparece un nuevo tipo de concierto, habría que agregar una nueva cláusula para el predicado cumpleRequisitos/2
dado que define una cláusula para un vocaloid por cada tipo de concierto.
Esta implementación es facilitada por el concepto de polimorfismo, dado que dicho predicado se utiliza de manera polimórfica para
distintos tipos de conciertos (functores) con diferentes aridades.
*/