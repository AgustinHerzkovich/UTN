vuelo(arg845, 30, [escala(rosario,0), tramo(2), escala(buenosAires,0)]).

vuelo(mh101, 95, [escala(kualaLumpur,0), tramo(9), escala(capeTown,2),
tramo(15), escala(buenosAires,0)]).

vuelo(dlh470, 60, [escala(berlin,0), tramo(9), escala(washington,2), tramo(2), escala(nuevaYork,0)]).

vuelo(aal1803, 250, [escala(nuevaYork,0), tramo(1), escala(washington,2),
tramo(3), escala(ottawa,3), tramo(15), escala(londres,4), tramo(1),
escala(paris,0)]).

vuelo(ble849, 175, [escala(paris,0), tramo(2), escala(berlin,1), tramo(3),
escala(kiev,2), tramo(2), escala(moscu,4), tramo(5), escala(seul,2), tramo(3), escala(tokyo,0)]).

vuelo(npo556, 150, [escala(kiev,0), tramo(1), escala(moscu,3), tramo(5),
escala(nuevaDelhi,6), tramo(2), escala(hongKong,4), tramo(2), escala(shanghai,5), tramo(3), escala(tokyo,0)]).

vuelo(dsm3450, 75, [escala(santiagoDeChile,0), tramo(1), escala(buenosAires,2), tramo(7), escala(washington,4), tramo(15), escala(berlin,3), tramo(15), escala(tokyo,0)]).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
tiempoTotalVuelo(Vuelo, TiempoTotal) :-
    destinos(Vuelo, Destinos),
    findall(Tiempo, tiempo(Tiempo,Destinos), Tiempos),
    sumlist(Tiempos, TiempoTotal).

destinos(Vuelo, Destinos) :-
    vuelo(Vuelo, _, Destinos).

tiempo(Tiempo, Destinos) :-
    tiempoDestino(Tiempo, Destino), 
    member(Destino, Destinos).

tiempoDestino(Tiempo, escala(_, Tiempo)).

tiempoDestino(Tiempo, tramo(Tiempo)).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
escalaAburrida(Vuelo , Escala) :-
    escalaPerteneciente(Vuelo, Escala),
    esAburrida(Escala).

escalaPerteneciente(Vuelo, Escala) :-
    esEscala(Escala),
    destinos(Vuelo, Destinos),
    member(Escala, Destinos).

esAburrida(escala(_, Tiempo)) :-
    Tiempo > 3.

esEscala(escala(_, _)).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
ciudadesAburridas(Vuelo, Ciudades) :-
    esVuelo(Vuelo),
    findall(Ciudad, escalaAburrida(Vuelo, escala(Ciudad, _)), Ciudades).

esVuelo(Vuelo) :-
    vuelo(Vuelo, _, _).
%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
vueloLargo(Vuelo) :-
    tiempoEnAire(Vuelo, Tiempo),
    Tiempo >= 10.

tiempoEnAire(Vuelo, TiempoTotal) :-
    destinos(Vuelo, Destinos),
    findall(Tiempo, tiempo2(Tiempo, Destinos), Tiempos),
    sumlist(Tiempos, TiempoTotal).

tiempo2(Tiempo, Destinos) :-
    tiempoDestino(Tiempo, tramo(Tiempo)), 
    member(tramo(Tiempo), Destinos).

conectados(Vuelo1, Vuelo2) :-
    ciudad(Vuelo1, Ciudad),
    ciudad(Vuelo2, Ciudad),
    Vuelo1 \= Vuelo2.

ciudad(Vuelo, Ciudad) :-
    ciudades(Vuelo, Ciudades),
    member(Ciudad, Ciudades).

ciudades(Vuelo, Ciudades) :-
    esVuelo(Vuelo),
    findall(Ciudad, escalaPerteneciente(Vuelo, escala(Ciudad, _)), Ciudades).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
bandaDeTres(Vuelo1, Vuelo2, Vuelo3) :-
    conectados(Vuelo1, Vuelo2),
    conectados(Vuelo2, Vuelo3).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
distanciaEnEscalas(Ciudad1, Ciudad2, Distancia) :-
    escalas(_, Escalas),
    nth1(Posicion1, Escalas, escala(Ciudad1, _)),
    nth1(Posicion2, Escalas, escala(Ciudad2, _)),
    Posicion1 \= Posicion2,
    Diferencia is Posicion2 - Posicion1,
    abs(Diferencia, Distancia),

escalas(Vuelo, Escalas) :-
    esVuelo(Vuelo),
    findall(Escala, escalaPerteneciente(Vuelo, Escala), Escalas).

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
vueloLento(Vuelo) :-
    esVuelo(Vuelo),
    not(vueloLargo(Vuelo)),
    forall(escalaPerteneciente(Vuelo, Escala), esAburrida(Escala)).