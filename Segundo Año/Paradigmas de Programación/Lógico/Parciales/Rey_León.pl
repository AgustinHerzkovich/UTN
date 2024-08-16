%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia, 3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger, 15, 6)).
comio(pumba, cucaracha(erikElRojo, 25, 70)).
comio(timon, vaquitaSanAntonio(romualda, 4)).
comio(timon, cucaracha(gimeno, 12, 8)).
comio(timon, cucaracha(cucurucha, 12, 5)).
comio(simba, vaquitaSanAntonio(remeditos, 4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).
comio(shenzi,hormiga(conCaraDeSimba)).
pesoBicho(hormiga(_), 2).
pesoBicho(vaquitaSanAntonio(_, Peso), Peso).
pesoBicho(cucaracha(_, _, Peso), Peso).

%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).
peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% a.
jugosita(Cucaracha) :-
    esBicho(Cucaracha),
    esBicho(OtraCucaracha),
    tamanio(Cucaracha, Tamanio),
    tamanio(OtraCucaracha, Tamanio),
    Cucaracha \= OtraCucaracha,
    pesoBicho(Cucaracha, PesoMayor),
    pesoBicho(OtraCucaracha, PesoMenor),
    PesoMayor > PesoMenor.

tamanio(cucaracha(_, Tamanio, _), Tamanio).

esBicho(Bicho) :-
    comio(_, Bicho).

% b.
hormigofilico(Personaje) :-
    comio(Personaje, hormiga(Hormiga1)),
    comio(Personaje, hormiga(Hormiga2)),
    Hormiga1 \= Hormiga2.

% c.
cucarachofobico(Personaje) :-
    personaje(Personaje),
    not(comioCucaracha(Personaje)).

personaje(Personaje) :-
    peso(Personaje, _).
personaje(Personaje) :-
    comio(Personaje, _).
personaje(Personaje) :-
    persigue(Personaje, _).
personaje(Personaje) :-
    persigue(_, Personaje).

comioCucaracha(Personaje) :-
    comio(Personaje, cucaracha(_, _, _)).

% d.
picarones(Personajes) :-
    findall(Personaje, picaron(Personaje), Personajes).

picaron(Personaje) :-
    comio(Personaje, Cucaracha),
    jugosita(Cucaracha).

picaron(Personaje) :-
    comio(Personaje, vaquitaSanAntonio(remeditos, _)).

picaron(pumba).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
persigue(scar, timon).
persigue(scar, pumba).
persigue(scar, mufasa).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).

cuantoEngorda(Personaje, Peso) :-
    distinct(Peso, (personaje(Personaje),
    bichosComidos(Personaje, PesoTotalBichos),
    victimasPerseguidas(Personaje, PesoTotalVictimas),
    victimasEngordadas(Personaje, PesoTotalAlimentosVictimas),
    Peso is PesoTotalBichos + PesoTotalVictimas + PesoTotalAlimentosVictimas)).

bichosComidos(Personaje, PesoTotalBichos) :-
    findall(PesoBicho, (comio(Personaje, Bicho), pesoBicho(Bicho, PesoBicho)), PesosBichos),
    sumlist(PesosBichos, PesoTotalBichos).

victimasPerseguidas(Personaje, PesoTotalVictimas) :-
    findall(PesoVictima, (persigue(Personaje, Victima), peso(Victima, PesoVictima)), PesosVictimas),
    sumlist(PesosVictimas, PesoTotalVictimas).

victimasEngordadas(Personaje, PesoTotalAlimentosVictimas) :-
    findall(AlimentoVictima, (persigue(Personaje, Victima), cuantoEngorda(Victima, AlimentoVictima)), AlimentosVictimas),
    sumlist(AlimentosVictimas, PesoTotalAlimentosVictimas).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
rey(Rey) :-
    personaje(Rey),
    todosAdoran(Rey),
    soloUnoLoPersigue(Rey).

animal(Animal) :-
    esBicho(Animal).

animal(Animal) :-
    personaje(Animal).

todosAdoran(PersonajeAdorado) :-
    animal(PersonajeAdorado),
    forall(animal(Animal), adora(PersonajeAdorado, Animal)).

adora(PersonajeAdorado, Adorador) :-
    esBicho(Adorador),
    not(comio(PersonajeAdorado, Adorador)).

adora(PersonajeAdorado, Adorador) :-
    personaje(Adorador),
    not(persigue(PersonajeAdorado, Adorador)).

soloUnoLoPersigue(Personaje) :-
    persigue(Perseguidor, Personaje),
    forall((persigue(OtroPerseguidor, _), OtroPerseguidor \= Perseguidor), not(persigue(OtroPerseguidor, Personaje))).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
% a. Polimorfismo para el predicado comio

% b. Recursividad no se utilizó

% c. Inversibilidad para los predicados principales