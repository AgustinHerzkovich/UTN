%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
% jugadores
% jugador(Nombre, PuntosVida, PuntosMana, CartasMazo, CartasMano, CartasCampo).

% cartas
% criatura(Nombre, PuntosDaño, PuntosVida, CostoMana)
% hechizo(Nombre, FunctorEfecto, CostoMana)

% efectos
% danio(CantidadDaño)
% cura(CantidadCura)


%Se cuenta con los siguientes predicados auxiliares:
nombre(jugador(Nombre,_,_,_,_,_), Nombre).
nombre(criatura(Nombre,_,_,_), Nombre).
nombre(hechizo(Nombre,_,_), Nombre).

vida(jugador(_,Vida,_,_,_,_), Vida).
vida(criatura(_,_,Vida,_), Vida).
vida(hechizo(_,curar(Vida),_), Vida).

danio(criatura(_,Danio,_), Danio).
danio(hechizo(_,danio(Danio),_), Danio).
mana(jugador(_,_,Mana,_,_,_), Mana).
mana(criatura(_,_,_,Mana), Mana).
mana(hechizo(_,_,Mana), Mana).

cartasMazo(jugador(_,_,_,Cartas,_,_), Cartas).
cartasMano(jugador(_,_,_,_,Cartas,_), Cartas).
cartasCampo(jugador(_,_,_,_,_,Cartas), Cartas).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
tieneCarta(Jugador, Carta) :-
    cartasJugador(Jugador, Cartas),
    member(Carta, Cartas).

cartasJugador(Jugador, Cartas) :-
    cartasMazo(Jugador, Cartas).
cartasJugador(Jugador, Cartas) :-
    cartasMano(Jugador, Cartas).
cartasJugador(Jugador, Cartas) :-
    cartasCampo(Jugador, Cartas).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
guerrero(Jugador) :-
    jugador(Jugador),
    forall(tieneCarta(Jugador, Carta), criatura(Carta)).

jugador(Jugador) :-
    tieneCarta(Jugador, _).

criatura(criatura(_, _, _, _)).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
jugarCarta(JugadorAntes, JugadorDespues) :-
    cartasMazo(JugadorAntes, CartasMazo),
    nth1(1, CartasMazo, PrimeraCarta),
    cartasMano(JugadorAntes, CartasManoAntes),
    append([PrimeraCarta], CartasManoAntes, CartasMano),
    cartasMano(JugadorDespues, CartasMano),
    nth1(1, CartasMano, PrimeraCarta),
    mana(JugadorAntes, ManaAntes),
    Mana is ManaAntes + 1,
    mana(JugadorDespues, Mana).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
% a.
puedeJugar(Jugador, Carta) :-
    mana(Jugador, ManaJugador),
    mana(Carta, ManaCarta),
    ManaJugador >= ManaCarta.

% b.
vaAPoderJugar(Jugador, Cartas) :-
    jugador(Jugador),
    findall(Carta, puedeJugarProximoTurno(Jugador, Carta), Cartas).

puedeJugarProximoTurno(Jugador, Carta) :-
    jugarCarta(Jugador, JugadorDespues),
    cartasMano(JugadorDespues, CartasMano),
    member(Carta, CartasMano),
    puedeJugar(JugadorDespues, Carta).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
posiblesJugadas(Jugador, Jugada) :-
    jugador(Jugador),
    findall(Carta, noQuedaNegativo(Jugador, Carta), Jugada).

noQuedaNegativo(Jugador, Carta) :-
    jugar(Jugador, JugadorDespues, Carta),
    mana(JugadorDespues, Mana),
    Mana > 0.

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
cartaMasDanina(Jugador, Carta) :-
    tieneCarta(Jugador, Carta),
    forall(tieneCarta(Jugador, OtraCarta), haceMasDanio(Carta, OtraCarta)).

haceMasDanio(Carta, OtraCarta) :-
    danio(Carta, Danio1),
    danio(OtraCarta, Danio2),
    Danio1 >= Danio2.

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
% a.
jugarContra(JugadorAntes, JugadorDespues, Carta) :-
    esHechizo(Carta),
    reducirVida(JugadorAntes, JugadorDespues, Carta).

reducirVida(JugadorAntes, JugadorDespues, Carta) :-
    vida(JugadorAntes, VidaAntes),
    danio(Carta, Danio),
    VidaDespues is VidaAntes - Danio,
    vida(JugadorDespues, VidaDespues).

esHechizo(hechizo(_, _, _)).

% b.
jugar(JugadorAntes, JugadorDespues, Carta) :-
    puedeJugar(JugadorAntes, Carta),
    jugarCarta(JugadorAntes, JugadorDespues).
jugar(JugadorAntes, JugadorDespues, Carta) :-
    puedeJugar(JugadorAntes, Carta),
    jugarCarta(JugadorAntes, JugadorDespues),
    hechizoDeCura(Carta),
    aumentarvida(JugadorAntes, JugadorDespues, Carta).

hechizoDeCura(Carta) :-
    esHechizo(Carta),
    vida(Carta, _).

aumentarvida(JugadorAntes, JugadorDespues, Carta) :-
    vida(JugadorAntes, VidaAntes),
    vida(Carta, Curacion),
    VidaDespues is VidaAntes + Curacion,
    vida(JugadorDespues, VidaDespues).