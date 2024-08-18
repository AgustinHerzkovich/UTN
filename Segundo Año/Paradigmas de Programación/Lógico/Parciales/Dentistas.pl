% base de conocimiento
% pacienteObraSocial(nombre paciente, numero legajo, nombre obra)
% pacienteParticular(nombre paciente, edad)
% pacienteClinica(nombre paciente, nombre clinica)

dentista(pereyra).
dentista(deLeon).
dentista(cureta).
dentista(patolinger).
dentista(saieg).

% costo de servicios para cada obra social
costo(osde, tratamientoConducto, 200).
costo(omint, tratamientoConducto, 250).
% costo de servicios por atención particular
costo(tratamientoConducto, 1200).
% porcentaje que se cobra a clínicas asociadas
clinica(odontoklin, 80).

puedeAtenderA(pereyra, pacienteObraSocial(karlsson, 1231, osde)).
puedeAtenderA(pereyra, pacienteParticular(rocchio, 24)).
puedeAtenderA(deLeon, pacienteClinica(dodino, odontoklin)).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
% puedeAtenderA(dentista, paciente).
puedeAtenderA(cureta, pacienteParticular(_, Edad)) :-
    Edad > 60.
puedeAtenderA(cureta, pacienteClinica(_, sarlanga)).

puedeAtenderA(patolinger, Paciente) :-
    puedeAtenderA(pereyra, Paciente).
puedeAtenderA(patolinger, Paciente) :-
    paciente(Paciente),
    not(puedeAtenderA(deLeon, Paciente)).

puedeAtenderA(saieg, Paciente) :-
    paciente(Paciente).

paciente(pacienteObraSocial(_, _, _)).
paciente(pacienteParticular(_, _)).
paciente(pacienteClinica(_, _)).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
% precio(paciente, servicio, precio).
precio(pacienteObraSocial(_, _, ObraSocial), Servicio, Precio) :-
    costo(ObraSocial, Servicio, Precio).

precio(pacienteParticular(_, Edad), Servicio, Precio) :-
    Edad =< 45,
    costo(Servicio, Precio).
precio(pacienteParticular(_, Edad), Servicio, Precio) :-
    Edad > 45,
    costo(Servicio, Costo),
    Precio is Costo + 50.

precio(pacienteClinica(_, Clinica), Servicio, Precio) :-
    costo(Servicio, Costo),
    clinica(Clinica, Porcentaje),
    Precio is Costo * Porcentaje / 100.

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
% servicioRealizado(fecha, dentista, servicio(servicio, functor paciente)).
servicioRealizado(fecha(10, 11, 2010), pereyra, servicio(tratamientoConducto, pacienteObraSocial(karlsson, 1231, osde))).
servicioRealizado(fecha(16, 11, 2010), pereyra, servicio(tratamientoConducto, pacienteClinica(dodino, odontoklin))).
servicioRealizado(fecha(21, 12, 2010), deLeon, servicio(tratamientoConducto, pacienteObraSocial(karlsson, 1231, osde))).

% montoFacturacion(dentista, mes, dinero).
montoFacturacion(Dentista, Mes, Dinero) :-
    dentista(Dentista),
    findall(Precio, precioPorServicio(Dentista, Mes, Precio), Precios),
    sumlist(Precios, Dinero).

precioPorServicio(Dentista, Mes, Precio) :-
    servicioRealizado(fecha(_, Mes, _), Dentista, servicio(Servicio, Paciente)),
    precio(Paciente, Servicio, Precio).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
% dentistaCool(dentista).
dentistaCool(Dentista) :-
    atendioAAlguien(Dentista),
    forall(pacienteAtendido(Dentista, Paciente), esInteresante(Paciente)).

pacienteAtendido(Dentista, Paciente) :-
    servicioRealizado(_, Dentista, servicio(_, Paciente)).

esInteresante(pacienteObraSocial(_, _, ObraSocial)) :-
    costo(ObraSocial, tratamientoConducto, Precio),
    Precio > 1000.
esInteresante(pacienteParticular(_, _)).

atendioAAlguien(Dentista) :-
    servicioRealizado(_, Dentista, _).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
confia(pereyra, deLeon).
confia(cureta, pereyra).

% atiendeDeUrgenciaA(Dentista, Paciente).
atiendeDeUrgenciaA(Dentista, Paciente) :-
    puedeAtenderA(Dentista, Paciente).

atiendeDeUrgenciaA(Dentista, Paciente) :-
    confia(Dentista, DentistaDeConfianza),
    atiendeDeUrgenciaA(DentistaDeConfianza, Paciente).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
serviciosCaros(osde, [tratamientoConducto, implanteOseo]).

% pacienteAlQueLeVieronLaCara(paciente).
pacienteAlQueLeVieronLaCara(Paciente) :-
    pacienteAtendido(Paciente),
    forall(servicioRecibido(Paciente, Servicio), esCaro(Servicio, Paciente)).

pacienteAtendido(Paciente) :-
    servicioRealizado(_, _, servicio(_, Paciente)).

servicioRecibido(Paciente, Servicio) :-
    servicioRealizado(_, _, servicio(Servicio, Paciente)).

esCaro(Servicio, pacienteObraSocial(_, _, ObraSocial)) :-
    serviciosCaros(ObraSocial, ServiciosCaros),
    member(Servicio, ServiciosCaros).

esCaro(Servicio, pacienteParticular(_, Edad)) :-
    precio(pacienteParticular(_, Edad), Servicio, Precio),
    Precio > 500.

%%%%%%%%%%%%
% Punto 07 %
%%%%%%%%%%%%
% serviciosMalHechos(dentista, [servicioMalRealizado]).
serviciosMalHechos(Dentista, Servicios) :-
    servicioRealizado(_, Dentista, _),
    findall(Servicio, malRealizado(Dentista, Servicio), Servicios).

malRealizado(Dentista, Servicio) :-
    dentista(OtroDentista),
    servicioRealizado(fecha(_, Mes, _), Dentista, servicio(Servicio, _)),
    MesSiguiente is Mes + 1,
    servicioRealizado(fecha(_, MesSiguiente, _), OtroDentista, servicio(Servicio, _)).