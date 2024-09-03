%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% jockey(Nombre, Altura, Peso).
jockey(valdivieso, 155, 52).
jockey(leguisamo, 161, 49).
jockey(lezcano, 149, 50).
jockey(baratucci, 153, 55).
jockey(falero, 157, 52).

% caballo(Nombre).
caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).

% prefiere(Caballo, Jockey).
prefiere(botafogo, Jockey) :-
    pesaMenosDe(Jockey, 52).
prefiere(botafogo, baratucci).
prefiere(oldMan, Jockey) :-
    muchasLetras(Jockey).
prefiere(energica, Jockey) :-
    leJockey(Jockey),
    not(prefiere(botafogo, Jockey)).
prefiere(matBoy, Jockey) :-
    mideMasDe(Jockey, 170).

pesaMenosDe(Jockey, Peso) :-
    jockey(Jockey, _, PesoJockey),
    PesoJockey < Peso.

muchasLetras(Jockey) :-
    leJockey(Jockey),
    atom_length(Jockey, Letras),
    Letras > 7.

leJockey(Jockey) :-
    jockey(Jockey, _, _).

mideMasDe(Jockey, Altura) :-
    jockey(Jockey, AlturaJockey, _),
    AlturaJockey > Altura.

% stud(Jockey, Stud).
stud(valdivieso, elTute).
stud(falero, elTute).
stud(lezcano, lasHormigas).
stud(baratucci, elCharabon).
stud(leguisamo, elCharabon).

% gano(Caballo, Premio).
gano(botafogo, granPremioNacional).
gano(botafogo, granPremioRepublica).
gano(oldMan, granPremioRepublica).
gano(oldMan, campeonatoPalermoDeOro).
gano(matBoy, granPremioCriadores).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
prefiereMasDeUno(Caballo) :-
    prefiere(Caballo, Jockey1),
    prefiere(Caballo, Jockey2),
    Jockey1 \= Jockey2.

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
aborrece(Caballo, Stud) :-
    caballo(Caballo),
    stud(_, Stud),
    forall(stud(Jockey, Stud), not(prefiere(Caballo, Jockey))).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
piolin(Jockey) :-
    leJockey(Jockey),
    forall(caballoImportante(Caballo), prefiere(Caballo, Jockey)).

caballoImportante(Caballo) :-
    gano(Caballo, Premio),
    importante(Premio).

importante(granPremioNacional).
importante(granPremioRepublica).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
apuestaGanadora(ganadorPorCaballo(Caballo), Resultado) :-
    salePrimero(Caballo, Resultado).
apuestaGanadora(segundoPorCaballo(Caballo), Resultado) :-
    primeroOSegundo(Caballo, Resultado).
apuestaGanadora(exacta(Caballo1, Caballo2), Resultado) :-
    salePrimero(Caballo1, Resultado),
    saleSegundo(Caballo2, Resultado).
apuestaGanadora(imperfecta(Caballo1, Caballo2), Resultado) :-
    primeroOSegundo(Caballo1, Resultado),
    primeroOSegundo(Caballo2, Resultado).

salePrimero(Caballo, Carrera) :-
    salePosicion(1, Caballo, Carrera).
saleSegundo(Caballo, Carrera) :-
    salePosicion(2, Caballo, Carrera).

salePosicion(Posicion, Caballo, Carrera) :-
    nth1(Posicion, Carrera, Caballo).

primeroOSegundo(Caballo, Carrera) :-
    salePrimero(Caballo, Carrera).
primeroOSegundo(Caballo, Carrera) :-
    saleSegundo(Caballo, Carrera).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
% crin(Caballo, Crin).
crin(botafogo, tordo).
crin(oldMan, alazan).
crin(energica, ratonero).
crin(matBoy, palomino).
crin(yatasto, pinto).

% color(Crin, Color).
color(tordo, negro).
color(alazan, marron).
color(ratonero, gris).
color(ratonero, negro).
color(palomino, marron).
color(palomino, blanco).
color(yatasto, marron).
color(yatasto, blanco).

% prefiereColor(Persona, Color).
prefiereColor(fede, marron).
prefiereColor(feli, blanco).
prefiereColor(agus, negro).

puedeComprar(Persona, Caballos) :-
    prefiereColor(Persona, Color),
    caballosDeColor(Color, CaballosPosibles),
    combinaciones(CaballosPosibles, Caballos),
    Caballos \= [].

caballosDeColor(Color, Caballos) :-
    color(_, Color),
    findall(Caballo, poseeColor(Caballo, Color), Caballos).

poseeColor(Caballo, Color) :-
    crin(Caballo, Crin),
    color(Crin, Color).

combinaciones([], []).
combinaciones([Caballo | Caballos], [Caballo | CombinacionCaballos]) :-
    combinaciones(Caballos, CombinacionCaballos).
combinaciones([_ | Caballos], CombinacionCaballos) :-
    combinaciones(Caballos, CombinacionCaballos).