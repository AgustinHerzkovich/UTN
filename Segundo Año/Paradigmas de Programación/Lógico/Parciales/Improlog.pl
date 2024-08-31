%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
/*
integrante/3 relaciona a un grupo, con una persona que toca en ese grupo y el instrumento que toca en ese grupo.
nivelQueTiene/3 relaciona a una persona con un instrumento que toca y qué tan bien puede improvisar con dicho instrumento (que representaremos con un número del 1 al 5).
instrumento/2 que relaciona el nombre de un instrumento con el rol que cumple el mismo al tocar en un grupo. Todos los instrumentos se considerarán rítmicos, armónicos o melódicos. Para los melódicos se incluye información adicional del tipo de instrumento (si es de cuerdas, viento, etc).
*/

integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(jazzmin, santi, bateria).

nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).

instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
buenaBase(Grupo) :-
    algunoToca(Grupo, ritmico),
    algunoToca(Grupo, armonico).

algunoToca(Grupo, TipoInstrumento) :-
    integrante(Grupo, _, Instrumento),
    instrumento(Instrumento, TipoInstrumento).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
destaca(Persona, Grupo) :-
    integrante(Grupo, Persona, _),
    forall((integrante(Grupo, OtraPersona, _), OtraPersona \= Persona), tocaMejor(Grupo, Persona, OtraPersona)).

tocaMejor(Grupo, Persona, OtraPersona) :-
    integrante(Grupo, Persona, Instrumento1),
    integrante(Grupo, OtraPersona, Instrumento2),
    nivelQueTiene(Persona, Instrumento1, Nivel1),
    nivelQueTiene(OtraPersona, Instrumento2, Nivel2),
    Diferencia is Nivel2 + 2,
    Nivel1 >= Diferencia.

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
% a.
grupo(vientosDelEste, bigBand).

% b.
grupo(sophieTrio, formacionParticular([contrabajo, guitarra, violin])).

% c.
grupo(jazzmin, formacionParticular([bateria, bajo, trompeta, piano, guitarra])).

grupo(estudio1, ensamble(3)). % Agregado por Punto 08

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
hayCupo(_, Grupo) :-
    grupo(Grupo, bigBand).
hayCupo(Instrumento, Grupo) :-
    nadieToca(Instrumento, Grupo),
    sirve(Instrumento, Grupo).

nadieToca(Instrumento, Grupo) :-
    integrante(Grupo, _, _),
    forall(integrante(_,  Grupo, OtroInstrumento), Instrumento \= OtroInstrumento).

sirve(Instrumento, Grupo) :-
    grupo(Grupo, formacionParticular(Instrumentos)),
    member(Instrumento, Instrumentos).
sirve(Instrumento, Grupo) :-
    grupo(Grupo, bigBand),
    instrumentoBigBandero(Instrumento).
sirve(Instrumento, Grupo) :- % Agregado por Punto 08
    grupo(Grupo, ensamble(_)),
    instrumento(Instrumento, _).

instrumentoBigBandero(Instrumento) :-
   viento(Instrumento).
instrumentoBigBandero(bateria).
instrumentoBigBandero(bajo).
instrumentoBigBandero(piano).

viento(Instrumento) :-
    instrumento(Instrumento, melodico(viento)).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
puedeIncorporarse(Persona, Grupo, Instrumento) :-
    noEsParteDe(Persona, Grupo),
    hayCupo(Instrumento, Grupo),
    nivelQueTiene(Persona, Instrumento, Nivel),
    nivelMinimoEsperado(Grupo, NivelMinimo),
    Nivel >= NivelMinimo.

noEsParteDe(Persona, Grupo) :-
    persona(Persona),
    not(integrante(Grupo, Persona, _)).

nivelMinimoEsperado(Grupo, 1) :-
    grupo(Grupo, bigBand).
nivelMinimoEsperado(Grupo, Nivel) :-
    grupo(Grupo, formacionParticular(Instrumentos)),
    length(Instrumentos, Cantidad),
    Nivel is 7 - Cantidad.
nivelMinimoEsperado(Grupo, Nivel) :- % Agregado por Punto 08
    grupo(Grupo, ensamble(Nivel)).

persona(Persona) :-
    nivelQueTiene(Persona, _, _).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
quedoEnBanda(Persona) :-
    persona(Persona),
    noEsParteDe(Persona, _),
    not(puedeIncorporarse(Persona, _, _)).

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
puedeTocar(Grupo) :-
    grupo(Grupo, bigBand),
    buenaBase(Grupo),
    cincoTocanViento(Grupo).
puedeTocar(Grupo) :-
    grupo(Grupo, formacionParticular(InstrumentosRequeridos)),
    forall(member(Instrumento, InstrumentosRequeridos), alguienToca(Grupo, Instrumento)).
puedeTocar(Grupo) :- % Agregado por Punto 08
    grupo(Grupo, ensamble(_)),
    buenaBase(Grupo),
    alguienToca(Grupo, Instrumento),
    instrumento(Instrumento, melodico(_)).

cincoTocanViento(Grupo) :-
    findall(InstrumentoViento, (integrante(_, Grupo, InstrumentoViento), viento(InstrumentoViento)), InstrumentosViento),
    length(InstrumentosViento, Cantidad),
    Cantidad >= 5.

alguienToca(Grupo, Instrumento) :-
    integrante(Grupo, _, Instrumento).

%%%%%%%%%%%%
% Punto 08 %
%%%%%%%%%%%%
% AGREGADO.