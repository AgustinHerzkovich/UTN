%%%%%%%%%%%%
% Registro %
%%%%%%%%%%%%
% persona(Nombre, Edad, Género).
persona(fede, 36, masculino).
persona(agus, 20, masculino).
persona(pepe, 17, femenino).

% preferencias(Persona, Géneros, rangoEtario(EdadMínima, EdadMáxima), Gustos, Disgustos).
preferencias(fede, [masculino, femenino], rangoEtario(70, 99), [anime, videojuegos, comer(comidaChatarra)], [leer, madrugar]).
preferencias(agus, [], rangoEtario(20, 25), [estudiar, entrenar, pasear, comer(comidaSaludable), videojuegos], [madrugar, salirDeFiesta, bebidas(alcohol)]).

%%%%%%%%%%%%
% Análisis %
%%%%%%%%%%%%
% perfilIncompleto(Persona).
perfilIncompleto(Persona) :-
    persona(Persona),
    not(datosCompletos(Persona)).
perfilIncompleto(Persona) :-
    menorDeEdad(Persona).

persona(Persona) :-
    persona(Persona, _, _).

datosCompletos(Persona) :-
    preferencias(Persona, Generos, _, Gustos, Disgustos),
    Generos \= [],
    cantidadMinima(Gustos),
    cantidadMinima(Disgustos).

cantidadMinima(Preferencias) :-
    length(Preferencias, Cantidad),
    Cantidad >= 5.

menorDeEdad(Persona) :-
    edad(Persona, Edad),
    Edad < 18.

edad(Persona, Edad) :-
    persona(Persona, Edad, _).

% almaLibre(Persona).
almaLibre(Persona) :-
    omniGeneroAmoroso(Persona).
almaLibre(Persona) :-
    rangoEtarioAceptadoMayorA(Persona, 30).

omniGeneroAmoroso(Persona) :-
    persona(Persona),
    forall(genero(Genero), sienteInteresRomantico(Persona, Genero)).

genero(Genero) :-
    persona(_, _, Genero).

sienteInteresRomantico(Persona, Genero) :-
    preferencias(Persona, Generos, _, _, _),
    member(Genero, Generos).

rangoEtarioAceptadoMayorA(Persona, Rango) :-
    rangoAceptado(Persona, rangoEtario(EdadMinima, EdadMaxima)),
    RangoEtario is EdadMaxima - EdadMinima,
    RangoEtario > Rango.

rangoAceptado(Persona, RangoEtario) :-
    preferencias(Persona, _, RangoEtario, _, _).

% quiereLaHerencia(Persona).
quiereLaHerencia(Persona) :-
    rangoAceptado(Persona, rangoEtario(EdadMinima, _)),
    edad(Persona, Edad),
    EdadMinima >= Edad + 30.

% indeseable(Persona).
indeseable(Persona) :-
    persona(Persona),
    forall(persona(OtraPersona), not(pretendiente(OtraPersona, Persona))).    

%%%%%%%%%%%
% Matches %
%%%%%%%%%%%
% pretendiente(Pretendiente, Persona).
pretendiente(Persona1, Persona2) :-
    persona(Persona2, Edad, Genero),
    sienteInteresRomantico(Persona1, Genero),
    aceptaEdad(Persona1, Edad),
    gustoEnComun(Persona1, Persona2),
    Persona1 \= Persona2.

aceptaEdad(Persona, Edad) :-
    rangoAceptado(Persona, RangoEtario),
    incluida(Edad, RangoEtario).

incluida(Edad, rangoEtario(EdadMinima, EdadMaxima)) :-
    between(EdadMinima, EdadMaxima, Edad).

gustoEnComun(Persona1, Persona2) :-
    gusto(Persona1, Gusto),
    gusto(Persona2, Gusto).

gusto(Persona, Gusto) :-
    preferencias(Persona, _, _, Gustos, _),
    member(Gusto, Gustos).

% hayMatch(Persona1, Persona2).
hayMatch(Persona1, Persona2) :-
    pretendiente(Persona1, Persona2),
    pretendiente(Persona2, Persona1).

% trianguloAmoroso(Persona1, Persona2, Persona3).
trianguloAmoroso(Persona1, Persona2, Persona3) :-
    pretendiente(Persona1, Persona2),
    pretendiente(Persona2, Persona3),
    pretendiente(Persona3, Persona1),
    sinMatches(Persona1, Persona2, Persona3).

sinMatches(Persona1, Persona2, Persona3) :-
    not(hayMatch(Persona1, Persona2)),
    not(hayMatch(Persona2, Persona3)),
    not(hayMatch(Persona1, Persona3)).

% elUnoParaElOtro(Persona1, Persona2).
elUnoParaElOtro(Persona1, Persona2) :-
    hayMatch(Persona1, Persona2),
    seGustan(Persona1, Persona2).

seGustan(Persona1, Persona2) :-
    leGusta(Persona1, Persona2),
    leGusta(Persona2, Persona1).    

leGusta(Persona1, Persona2) :-
    forall(gusto(Persona2, Gusto), not(leDisgusta(Persona1, Gusto))).

leDisgusta(Persona, Gusto) :-
    disgustos(Persona, Disgustos),
    member(Gusto, Disgustos).

disgustos(Persona, Disgustos) :-
    preferencias(Persona, _, _, _, Disgustos).

%%%%%%%%%%%%
% Mensajes %
%%%%%%%%%%%%
% indiceDeAmor(Emisor, Receptor, Índice).
indiceDeAmor(agus, fede, 0).
indiceDeAmor(fede, agus, 10).
indiceDeAmor(fede, agus, 8).
indiceDeAmor(agus, fede, 1).

% desbalance(Persona1, Persona2).
desbalance(Persona1, Persona2) :-
    masAmoroso(Persona1, Persona2).
desbalance(Persona1, Persona2) :-
    masAmoroso(Persona2, Persona1).

masAmoroso(Persona1, Persona2) :-
    indiceDeAmorPromedio(Persona1, Persona2, Promedio1),
    indiceDeAmorPromedio(Persona2, Persona1, Promedio2),
    Promedio1 > Promedio2 * 2.

indiceDeAmorPromedio(Emisor, Receptor, Promedio) :-
    indiceDeAmor(Emisor, Receptor, _),
    findall(IndiceDeAmor, indiceDeAmor(Emisor, Receptor, IndiceDeAmor), IndicesDeAmor),
    promedio(IndicesDeAmor, Promedio).

promedio(Indices, Promedio) :-
    length(Indices, Cantidad),
    sumlist(Indices, Total),
    Promedio is Total / Cantidad.

% ghostea(Ghosteador, Ghosteado).
ghostea(Persona1, Persona2) :-
    recibioMensaje(Persona1, Persona2),
    not(recibioMensaje(Persona2, Persona1)).

recibioMensaje(Receptor, Emisor) :-
    indiceDeAmor(Emisor, Receptor, _).