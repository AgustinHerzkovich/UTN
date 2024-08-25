%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
persona(bart).
persona(larry).
persona(otto).
persona(marge).

%los magios son functores alMando(nombre, antiguedad), novato(nombre) y elElegido(nombre).
magio(alMando(burns,29)).
magio(alMando(clark,20)).
magio(novato(lenny)).
magio(novato(carl)).
magio(elElegido(homero)).

% Y contamos con algunos hechos en nuestra base
hijo(homero,abbe).
hijo(bart,homero).
hijo(larry,burns).

salvo(carl,lenny).
salvo(homero,larry).
salvo(otto,burns).

%Los beneficios son funtores confort(descripcion), confort(descripcion, caracteristica), 
% dispersion(descripcion), economico(descripcion, monto).
gozaBeneficio(carl, confort(sillon)).
gozaBeneficio(lenny, confort(sillon)).
gozaBeneficio(lenny, confort(estacionamiento, techado)).
gozaBeneficio(carl, confort(estacionamiento, libre)).
gozaBeneficio(clark, confort(viajeSinTrafico)).
gozaBeneficio(clark, dispersion(fiestas)).
gozaBeneficio(burns, dispersion(fiestas)).
gozaBeneficio(lenny, economico(descuento, 500)).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
aspiranteAMagio(Persona) :-
    desciendeDeMagio(Persona).
aspiranteAMagio(Persona) :-
    salvoAUnMagio(Persona).

desciendeDeMagio(Persona) :-
    hijo(Persona, Padre),
    esMagioODescendiente(Padre).

esMagioODescendiente(Persona) :-
    magio(Persona).
esMagioODescendiente(Persona) :-
    desciendeDeMagio(Persona).

salvoAUnMagio(Persona) :-
    salvo(Persona, Alguien),
    magio(Alguien).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
puedeDarOrdenes(Ordenador, Ordenado) :-
    magio(alMando(Ordenador, Antiguedad)),
    novatoOMenorAntiguedad(Ordenado, Antiguedad).
puedeDarOrdenes(Ordenador, Ordenado) :-
    magio(elElegido(Ordenador)),
    magio(Ordenado).

novatoOMenorAntiguedad(Magio, _) :-
    magio(novato(Magio)).
novatoOMenorAntiguedad(Magio, AntiguedadMayor) :-
    magio(alMando(Magio, AntiguedadMenor)),
    AntiguedadMenor < AntiguedadMayor.

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
sienteEnvidia(Persona, Envidiados) :-
    persona(Persona),
    findall(Envidiado, envidia(Persona, Envidiado), Envidiados).

envidia(Persona, Envidiado) :-
    aspiranteAMagio(Persona),
    magio(Envidiado).
envidia(Persona, Envidiado) :-
    not(aspiranteAMagio(Persona)),
    aspiranteAMagio(Envidiado).
envidia(Persona, Envidiado) :-
    magio(novato(Persona)),
    magio(alMando(Envidiado, _)).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
masEnvidioso(Persona) :-
    sienteEnvidia(Persona, Envidiados),
    maximaCantidadDeEnvidiados(Envidiados).

maximaCantidadDeEnvidiados(Envidiados) :-
    forall(sienteEnvidia(_, OtrosEnvidiados), sonMas(Envidiados, OtrosEnvidiados)).

sonMas(Lista1, Lista2) :-
    length(Lista1, Cantidad1),
    length(Lista2, Cantidad2),
    Cantidad1 >= Cantidad2.

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
soloLoGoza(Persona, Beneficio) :-
    gozaBeneficio(Persona, Beneficio),
    forall((gozaBeneficio(OtraPersona, _), OtraPersona \= Persona), not(gozaBeneficio(OtraPersona, Beneficio))).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
tipoDeBeneficioMasAprovechado(TipoBeneficio) :-
    findall(Tipo, gozaTipoBeneficio(_, Tipo), TiposBeneficios),
    elementoMasFrecuente(TiposBeneficios, TipoBeneficio).

gozaTipoBeneficio(Persona, confort) :-
    gozaBeneficio(Persona, confort(_)).
gozaTipoBeneficio(Persona, confort) :-
    gozaBeneficio(Persona, confort(_, _)).
gozaTipoBeneficio(Persona, dispersion) :-
    gozaBeneficio(Persona, dispersion(_)).
gozaTipoBeneficio(Persona, economico) :-
    gozaBeneficio(Persona, economico(_, _)).

elementoMasFrecuente(Lista, Elemento) :-
    member(Elemento, Lista),
    forall(member(OtroElemento, Lista), mayorCantidad(Elemento, OtroElemento, Lista)).

mayorCantidad(Elemento, OtroElemento, Lista) :-
    cantidadElementos(Elemento, Lista, CantidadMayor),
    cantidadElementos(OtroElemento, Lista, CantidadMenor),
    CantidadMayor >= CantidadMenor.

cantidadElementos(Elemento, Lista, Cantidad) :-
    findall(Elemento, member(Elemento, Lista), Elementos),
    length(Elementos, Cantidad).

% Justificar
/*Se aprovechó el uso del polimorfismo para el predicado 'gozaTipoBeneficio/2', con el objetivo
de relacionar una persona con el tipo de beneficio del cual goza, dado que los beneficios se representan
con functores de distinta forma, fue necesario un predicado polimórfico que contemple todos los tipos de beneficio.
*/