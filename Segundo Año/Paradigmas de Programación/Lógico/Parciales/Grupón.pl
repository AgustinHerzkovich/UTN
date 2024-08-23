%%%%%%%%%%%%%%%%%%%%%%%%
% Base de conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
usuario(lider,capitalFederal).
usuario(alf,lanus).
usuario(roque,laPlata).
usuario(fede, capitalFederal).

% los functores cupon son de la forma
% cupon(Marca,Producto,PorcentajeDescuento)
cuponVigente(capitalFederal,cupon(elGatoNegro,setDeTe,35)).
cuponVigente(capitalFederal,cupon(lasMedialunasDelAbuelo,panDeQueso,43)).
cuponVigente(capitalFederal,cupon(laMuzzaInspiradora,pizzaYBirraParaDos,80)).
cuponVigente(lanus,cupon(maoriPilates,ochoClasesDePilates,75)).
cuponVigente(lanus,cupon(elTano,parrilladaLibre,65)).
cuponVigente(lanus,cupon(niniaBonita,depilacionDefinitiva,73)).

/*
El predicado accionDeUsuario registra las acciones que el usuario realiza en el sitio, que
pueden ser:
● comprar con un cupón, que se representa con un functor:
    compraCupon(PorcentajeDescuento,Fecha,Marca)
● recomendar un cupón, representado como:
    recomiendaCupon(Marca,Fecha,UsuarioRecomendado)
*/

accionDeUsuario(lider,compraCupon(60,"20/12/2010",laGourmet)).
accionDeUsuario(lider,compraCupon(50,"04/05/2011",elGatoNegro)).
accionDeUsuario(alf,compraCupon(74,"03/02/2011",elMundoDelBuceo)).
accionDeUsuario(fede,compraCupon(35,"05/06/2011",elTano)).
accionDeUsuario(fede,recomiendaCupon(elGatoNegro,"04/05/2011",lider)).
accionDeUsuario(lider,recomiendaCupon(cuspide,"13/05/2011",alf)).
accionDeUsuario(alf,recomiendaCupon(cuspide,"13/05/2011",fede)).
accionDeUsuario(fede,recomiendaCupon(cuspide,"13/05/2011",roque)).
accionDeUsuario(lider,recomiendaCupon(cuspide,"24/07/2011",fede)).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
ciudadGenerosa(Ciudad) :-
    ciudadCuponera(Ciudad),
    forall(cuponVigente(Ciudad, Cupon), ofreceMasDe(Cupon, 60)).

ciudadCuponera(Ciudad) :-
    cuponVigente(Ciudad, _).

ofreceMasDe(cupon(_, _, PorcentajeDescuento), Porcentaje) :-
    PorcentajeDescuento > Porcentaje.

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
puntosGanados(Persona, Puntos) :-
    puntosPersona(Persona, PuntosTotales, _),
    sumlist(PuntosTotales, Puntos).

puntosPersona(Persona, Puntos, Marca) :-
    persona(Persona),
    marca(Marca),
    findall(PuntosAccion, puntosPorAccionConMarca(Persona, PuntosAccion, Marca), Puntos).

persona(Persona) :-
    usuario(Persona, _).

marca(Marca) :-
    cuponVigente(_, cupon(Marca, _, _)).
marca(Marca) :-
    accionDeUsuario(_, Accion),
    accionDeMarca(Accion, Marca).

puntosPorAccionConMarca(Persona, PuntosAccion, Marca) :-
    accionDeUsuario(Persona, Accion),
    accionDeMarca(Accion, Marca), 
    puntosAccion(Accion, PuntosAccion).

accionDeMarca(compraCupon(_, _, Marca), Marca).
accionDeMarca(recomiendaCupon(Marca, _, _), Marca).

puntosAccion(Recomendacion, 5) :-
    recomendacionExitosa(Recomendacion).
puntosAccion(Recomendacion, 1) :-
    recomendacionNoExitosa(Recomendacion).
puntosAccion(compraCupon(_, _, _), 10).

recomendacionExitosa(recomiendaCupon(Marca, Fecha, Usuario)) :-
    accionDeUsuario(Usuario, compraCupon(_, Fecha, Marca)).

recomendacionNoExitosa(Recomendacion) :-
    not(recomendacionExitosa(Recomendacion)).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
promedioDePuntosPorMarca(Marca, PromedioPuntos) :-
    puntosPersona(_, Puntos, Marca),
    sumlist(Puntos, TotalPuntos),
    length(Puntos, Cantidad),
    Cantidad \= 0,
    PromedioPuntos is TotalPuntos / Cantidad.

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
lePuedeInteresarElCupon(Persona, Cupon) :-
    cuponVigente(Ciudad, Cupon),
    viveEn(Ciudad, Persona),
    empresaDeCupon(Empresa, Cupon),
    interactuoConLaEmpresa(Persona, Empresa).

viveEn(Ciudad, Persona) :-
    usuario(Persona, Ciudad).

empresaDeCupon(Empresa, cupon(Empresa, _, _)).

interactuoConLaEmpresa(Persona, Empresa) :-
    comproEnLaEmpresa(Persona, Empresa).
interactuoConLaEmpresa(Persona, Empresa) :-
    leRecomendaronLaEmpresa(Persona, Empresa).

comproEnLaEmpresa(Persona, Empresa) :-
    accionDeUsuario(Persona, compraCupon(_, _, Empresa)).

leRecomendaronLaEmpresa(Persona, Empresa) :-
    accionDeUsuario(_, recomiendaCupon(Empresa, _, Persona)).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
nadieLeDioBola(Usuario) :-
    persona(Usuario),
    forall(recomendacionRealizada(Usuario, Recomendacion), recomendacionNoExitosa(Recomendacion)).

recomendacionRealizada(Usuario, Recomendacion) :-
    recomendacion(Recomendacion),
    accionDeUsuario(Usuario, Recomendacion).

recomendacion(recomiendaCupon(_, _, _)).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
cadenaDeRecomendacionesValida(Marca, Fecha, Lista) :-
    cadenaDeRecomendacionesDeUsuario(_, Marca, Fecha, Lista).

% Caso base: La cadena de recomendaciones termina cuando un usuario recomienda un cupón
% pero la persona recomendada no lo recomienda a nadie más.
cadenaDeRecomendacionesDeUsuario(Usuario, Marca, Fecha, [Usuario]) :-
    accionDeUsuario(Usuario, recomiendaCupon(Marca, Fecha, PersonaRecomendada)),
    \+ accionDeUsuario(PersonaRecomendada, recomiendaCupon(Marca, Fecha, _)).

% Recursión: Si la persona recomendada vuelve a recomendar el mismo cupón en la misma fecha,
% entonces se continúa la cadena.
cadenaDeRecomendacionesDeUsuario(Usuario, Marca, Fecha, [Usuario | RestoDeCadena]) :-
    accionDeUsuario(Usuario, recomiendaCupon(Marca, Fecha, PersonaRecomendada)),
    cadenaDeRecomendacionesDeUsuario(PersonaRecomendada, Marca, Fecha, RestoDeCadena).