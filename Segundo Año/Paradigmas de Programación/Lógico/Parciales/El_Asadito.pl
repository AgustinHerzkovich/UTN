%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%

% define quiénes son amigos de nuestro cliente
amigo(mati). amigo(pablo). amigo(leo).
amigo(fer). amigo(flor).
amigo(ezequiel). amigo(marina).

% define quiénes no se pueden ver
noSeBanca(leo, flor). noSeBanca(pablo, fer).
noSeBanca(fer, leo). noSeBanca(flor, fer).

% define cuáles son las comidas y cómo se componen
% functor achura contiene nombre, cantidad de calorías
% functor ensalada contiene nombre, lista de ingredientes
% functor morfi contiene nombre (el morfi es una comida principal)
comida(achura(chori, 200)). % ya sabemos que el chori no es achura
comida(achura(chinchu, 150)).
comida(ensalada(waldorf, [manzana, apio, nuez, mayo])).
comida(ensalada(mixta, [lechuga, tomate, cebolla])).
comida(morfi(vacio)).
comida(morfi(mondiola)).
comida(morfi(asado)).

% relacionamos la comida que se sirvió en cada asado
% cada asado se realizó en una única fecha posible: functor fecha + comida
asado(fecha(22,9,2011), chori). asado(fecha(15,9,2011), mixta).
asado(fecha(22,9,2011), waldorf). asado(fecha(15,9,2011), mondiola).
asado(fecha(22,9,2011), vacio). asado(fecha(15,9,2011), chinchu).

% relacionamos quiénes asistieron a ese asado
asistio(fecha(15,9,2011), flor). asistio(fecha(22,9,2011), marina).
asistio(fecha(15,9,2011), pablo). asistio(fecha(22,9,2011), pablo).
asistio(fecha(15,9,2011), leo). asistio(fecha(22,9,2011), flor).
asistio(fecha(15,9,2011), fer). asistio(fecha(22,9,2011), mati).

% definimos qué le gusta a cada persona
leGusta(mati, chori). leGusta(fer, mondiola). leGusta(pablo, asado).
leGusta(mati, vacio). leGusta(fer, vacio).
leGusta(mati, waldorf). leGusta(flor, mixta).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% a.
leGusta(ezequiel, Comida) :-
    leGusta(mati, Comida),
    leGusta(fer, Comida).

% b.
leGusta(marina, Comida) :-
    leGusta(flor, Comida).
leGusta(marina, mondiola).

% c.
% No se añade cláusula por principio de universo cerrado.

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
asadoViolento(FechaAsado) :-
    fechaAsado(FechaAsado),
    forall(asistio(FechaAsado, Asistente), soportoAAlguienQueNoSeBanca(FechaAsado, Asistente)).

fechaAsado(Fecha) :-
    asado(Fecha, _).

soportoAAlguienQueNoSeBanca(Fecha, Asistente) :-
    asistio(Fecha, Asistente),
    asistio(Fecha, Inbancable),
    noSeBanca(Asistente, Inbancable).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
% a.
calorias(Ensalada, Calorias) :-
    comida(ensalada(Ensalada, Ingredientes)),
    length(Ingredientes, Calorias).

% b.
calorias(Achura, Calorias) :-
    comida(achura(Achura, Calorias)).

% c.
calorias(Morfi, 200) :-
    comida(morfi(Morfi)).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
asadoFlojito(FechaAsado) :-
    caloriasTotales(FechaAsado, Calorias),
    Calorias =< 400.

caloriasTotales(FechaAsado, TotalCalorias) :-
    fechaAsado(FechaAsado),
    findall(Calorias, caloriasDeComidaDeAsado(FechaAsado, Calorias), CaloriasTotales),
    sumlist(CaloriasTotales, TotalCalorias).

caloriasDeComidaDeAsado(FechaAsado, Calorias) :-
    asado(FechaAsado, Comida), 
    calorias(Comida, Calorias).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
hablo(fecha(15,09,2011), flor, pablo). hablo(fecha(22,09,2011), flor, marina).
hablo(fecha(15,09,2011), pablo, leo). hablo(fecha(22,09,2011), marina, pablo).
hablo(fecha(15,09,2011), leo, fer). reservado(marina).

chismeDe(FechaAsado, Chismoso, Chismeado) :-
    conoceChismeDirectamente(FechaAsado, Chismoso, Chismeado).
chismeDe(FechaAsado, Chismoso, Chismeado) :-
    conoceChismeIndirectamente(FechaAsado, Chismoso, Chismeado).

conoceChismeDirectamente(FechaAsado, Chismoso, Chismeado) :-
    chismoseo(FechaAsado, Chismeado, Chismoso).

conoceChismeIndirectamente(FechaAsado, Chismoso, Chismeado) :-
    chismoseo(FechaAsado, Alguien, Chismoso),
    chismeDe(FechaAsado, Alguien, Chismeado).

chismoseo(FechaAsado, Chismoso, Chismeado) :-
    amigo(Chismoso),
    not(reservado(Chismoso)),
    hablo(FechaAsado, Chismoso, Chismeado).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
disfruto(Persona, FechaAsado) :-
    asistio(FechaAsado, Persona),
    findall(Comida, pudoComer(Persona, FechaAsado, Comida), ComidasGustosas),
    length(ComidasGustosas, Cantidad),
    Cantidad >= 3.

pudoComer(Persona, FechaAsado, Comida) :-
    asado(FechaAsado, Comida), 
    leGusta(Persona, Comida).

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
asadoRico(ComidasPosibles) :-
    findall(Comida, comidaRica(Comida), Comidas),
    combinaciones(Comidas, ComidasPosibles),
    ComidasPosibles \= [].

combinaciones([], []).
combinaciones([_ | Resto], Combinacion) :-
    combinaciones(Resto, Combinacion).
combinaciones([Cabeza | Resto], [Cabeza | Combinacion]) :-
    combinaciones(Resto, Combinacion).

comidaRica(Comida) :-
    comida(Comida),
    esRica(Comida).

% a.
esRica(morfi(_)).

% b.
esRica(ensalada(_, Ingredientes)) :-
    length(Ingredientes, Cantidad),
    Cantidad > 3.

% c.
esRica(achura(chori, _)).
esRica(achura(morci, _)).