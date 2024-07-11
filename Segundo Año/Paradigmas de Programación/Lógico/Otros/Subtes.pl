linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).

combinacion([lima, avMayo]).
combinacion([once, miserere]).
combinacion([pellegrini, diagNorte, nueveJulio]).
combinacion([independenciaC, independenciaE]).
combinacion([jujuy, humberto1ro]).
combinacion([santaFe, pueyrredonD]).
combinacion([corrientes, pueyrredonB]).

% 1. estaEn/2: en qué línea está una estación.
estaEn(Linea,Estacion):-
    linea(Linea,Estaciones),
    member(Estacion,Estaciones).

% 2. distancia/3: dadas dos estaciones de la misma línea, cuántas estaciones hay entre ellas: por ejemplo, entre Perú y Primera Junta hay 5 estaciones.
distancia(Estacion1,Estacion2,Distancia):-
    mismaLinea(Estacion1,Estacion2),
    estaEn(Linea,Estacion1),
    linea(Linea,Estaciones),
    posicionEstacion(Estacion1,Estaciones,Posicion1),
    posicionEstacion(Estacion2,Estaciones,Posicion2),
    distancia is Posicion2 - Posicion1,
    abs(distancia,Distancia).

posicionEstacion(Estacion,Estaciones,Posicion):-
    nth1(Posicion,Estaciones,Estacion).

mismaLinea(Estacion1,Estacion2):-
    Estacion1 \= Estacion2,
    estaEn(Linea,Estacion1),
    estaEn(Linea,Estacion2).

% 3. mismaAltura/2: dadas dos estaciones de distintas líneas, si están a la misma altura (o sea, las dos terceras, las dos quintas, etc.), por ejemplo: Pellegrini y Santa Fe están ambas segundas.
mismaAltura(Estacion1,Estacion2):-
    estacion(Estacion1),
    estacion(Estacion2),
    not(mismaLinea(Estacion1,Estacion2)),
    mismaPosicion(Estacion1,Estacion2).

estacion(Estacion):-
    estaEn(_,Estacion).

mismaPosicion(Estacion1,Estacion2):-
    lineas(Linea1,Linea2,Estacion1,Estacion2),
    estaciones(Linea1,Linea2,Estaciones1,Estaciones2),
    posicionEstacion(Estacion1,Estaciones1,Posicion1),
    posicionEstacion(Estacion2,Estaciones2,Posicion2),
    iguales(Posicion1,Posicion2).

iguales(Elemento,Elemento).

estaciones(Linea1,Linea2,Estaciones1,Estaciones2):-
    linea(Linea1,Estaciones1),
    linea(Linea2,Estaciones2).

lineas(Linea1,Linea2,Estacion1,Estacion2):-
    estaEn(Linea1,Estacion1),
    estaEn(Linea2,Estacion2).

% 4. granCombinacion/1: se cumple para una combinación de más de dos estaciones.
granCombinacion(Combinacion):-
    combinacion(Combinacion),
    length(Combinacion,Estaciones),
    Estaciones > 2.

% 5. cuantasCombinan/2: dada una línea, relaciona esa línea con la cantidad de estaciones de esa línea que tienen alguna combinación. Por ejemplo, la línea C tiene 3 estaciones que combinan (avMayo, diagNorte e independenciaC).
cuantasCombinan(Linea,Cantidad):-
    esLinea(Linea),
    findall(Estacion,combina(Linea,Estacion),Estaciones),
    length(Estaciones,Cantidad).

combina(Linea,Estacion):-
    estaEn(Linea,Estacion),
    combinacion(Combinacion),
    member(Estacion,Combinacion).

esLinea(Linea):-
    linea(Linea,_).

% 6. lineaMasLarga/1: es verdadero para la línea con más estaciones.
lineaMasLarga(Linea):-
    esLinea(Linea),
    forall(linea(OtraLinea,_),tieneMasEstaciones(Linea,OtraLinea)).

tieneMasEstaciones(Linea1,Linea2):-
    estaciones(Linea1,Linea2,Estaciones1,Estaciones2),
    longitudes(Estaciones1,Estaciones2,Cantidad1,Cantidad2),
    Cantidad1 >= Cantidad2.

longitudes(Estaciones1,Estaciones2,Cantidad1,Cantidad2):-
    length(Estaciones1,Cantidad1),
    length(Estaciones2,Cantidad2).

% 7. viajeFacil/2: dadas dos estaciones, si puedo llegar fácil de una a la otra; esto es, si están en la misma línea, o bien puedo llegar con una sola combinación.
viajeFacil(Estacion1,Estacion2):-
    mismaLinea(Estacion1,Estacion2).
viajeFacil(Estacion1,Estacion2):-
    unicaCombinacion(Estacion1,Estacion2).

unicaCombinacion(Estacion1,Estacion2):-
    lineas(Linea1,Linea2,Estacion1,Estacion2),
    conectadas(Linea1,Linea2).

conectadas(Linea1,Linea2):-
    estaciones(Linea1,Linea2,Estaciones1,Estaciones2),
    Linea1 \= Linea2,
    member(Estacion1,Estaciones1),
    member(Estacion2,Estaciones2),
    combinacion(Combinadas),
    ambasPertenecen(Estacion1,Estacion2,Combinadas).

ambasPertenecen(ListaElementos,Lista):-
    forall(member(Elemento,ListaElementos),member(Elemento,Lista)),
    member(Elemento1,Lista),
    member(Elemento2,Lista).