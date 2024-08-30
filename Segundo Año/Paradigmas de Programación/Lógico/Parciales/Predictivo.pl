%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
% mensaje(ListaDePalabras, Receptor).
%	Los receptores posibles son:
%	Persona: un simple átomo con el nombre de la persona; ó
%	Grupo: una lista de al menos 2 nombres de personas que pertenecen al grupo.
mensaje(['hola', ',', 'qué', 'onda', '?'], nico).
mensaje(['todo', 'bien', 'dsp', 'hablamos'], nico).
mensaje(['q', 'parcial', 'vamos', 'a', 'tomar', '?'], [nico, lucas, maiu]).
mensaje(['todo', 'bn', 'dsp', 'hablamos'], [nico, lucas, maiu]).
mensaje(['todo', 'bien', 'después', 'hablamos'], mama).
mensaje(['¿','y','q', 'onda', 'el','parcial', '?'], nico).
mensaje(['¿','y','qué', 'onda', 'el','parcial', '?'], lucas).

% abreviatura(Abreviatura, PalabraCompleta) relaciona una abreviatura con su significado.
abreviatura('dsp', 'después').
abreviatura('q', 'que').
abreviatura('q', 'qué').
abreviatura('bn', 'bien').

% signo(UnaPalabra) indica si una palabra es un signo.
signo('¿').    signo('?').   signo('.').   signo(','). 

% filtro(Contacto, Filtro) define un criterio a aplicar para las predicciones para un contacto
filtro(nico, masDe(0.5)).
filtro(nico, ignorar(['interestelar'])).
filtro(lucas, masDe(0.7)).
filtro(lucas, soloFormal).
filtro(mama, ignorar(['dsp','paja'])).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
recibioMensaje(Persona, Mensaje) :-
    recibioIndividualOGrupal(Mensaje, Persona).

recibioIndividualOGrupal(Mensaje, Persona) :-
    recibioIndividual(Mensaje, Persona).
recibioIndividualOGrupal(Mensaje, Persona) :-
    recibioGrupal(Mensaje, Persona).

recibioIndividual(Mensaje, Persona) :-
    persona(Persona),
    mensaje(Mensaje, Persona).

recibioGrupal(Mensaje, Persona) :-
    mensaje(Mensaje, Personas),
    member(Persona, Personas).

persona(Persona) :-
    mensaje(_, Persona),
    Persona \= [_ | _].

esMensaje(Mensaje) :-
    esMensaje(Mensaje).

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
demasiadoFormal(Mensaje) :-
    length(Mensaje, Palabras),
    Palabras > 20,
    incluyeSigno(Mensaje).
demasiadoFormal(Mensaje) :-
    esMensaje(Mensaje),
    comienzaCon('¿', Mensaje),
    not(tieneAbreviatura(Mensaje)).

incluyeSigno(Mensaje) :-
    signo(Signo),
    member(Signo, Mensaje).

comienzaCon(Palabra, Mensaje) :-
    nth1(1, Mensaje, Palabra).

tieneAbreviatura(Mensaje) :-
    member(Palabra, Mensaje),
    abreviatura(Palabra, _).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
esAceptable(Palabra, Persona) :-
    persona(Persona),
    forall(filtro(Persona, Filtro), pasaElFiltro(Palabra, Persona, Filtro)).

pasaElFiltro(Palabra, Persona, masDe(N)) :-
    tasaDeUso(Palabra, Persona, TasaDeUso),
    TasaDeUso > N.
pasaElFiltro(Palabra, _, ignorar(ListaDePalabras)) :-
    not(member(Palabra, ListaDePalabras)).
pasaElFiltro(Palabra, _, soloFormal) :-
    demasiadoFormal(Mensaje),
    member(Palabra, Mensaje).

tasaDeUso(Palabra, Persona, TasaDeUso) :-
    apariciones(Palabra, Persona, AparacionesEnPersona),
    apariciones(Palabra, _, AparacionesTotales),
    TasaDeUso is AparacionesEnPersona / AparacionesTotales.

apariciones(Palabra, Persona, AparacionesEnPersona) :-
    persona(Persona),
    findall(Palabra, (recibioMensaje(Mensaje, Persona), member(Palabra, Mensaje)), Palabras),
    length(Palabras, AparacionesEnPersona).

%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
dicenLoMismo(Mensaje1, Mensaje2) :-
    mensaje(Mensaje1, _),
    mensaje(Mensaje2, _),
    forall(nth1(Posicion, Mensaje1, Palabra1), nth1(Posicion, Mensaje2, Palabra2)),
    equivalentes(Palabra1, Palabra2).

equivalentes(Palabra, Palabra).
equivalentes(Palabra1, Palabra2) :-
    abreviatura(Palabra1, Palabra2).
equivalentes(Palabra1, Palabra2) :-
    abreviatura(Palabra2, Palabra1).

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
fraseCelebre(Mensaje) :-
    esMensaje(Mensaje),
    forall(persona(Persona), recibioMensajeOEquivalente(Persona, Mensaje)).

recibioMensajeOEquivalente(Persona, Mensaje) :-
    recibioMensaje(Persona, Mensaje).
recibioMensajeOEquivalente(Persona, Mensaje) :-
    recibioEquivalente(Persona, Mensaje).

recibioEquivalente(Persona, Mensaje) :-
    dicenLoMismo(Mensaje, Equivalente),
    recibioMensaje(Persona, Equivalente).
recibioEquivalente(Persona, Mensaje) :-
    dicenLoMismo(Equivalente, Mensaje),
    recibioMensaje(Persona, Equivalente).

%%%%%%%%%%%%
% Punto 06 %
%%%%%%%%%%%%
prediccion(Mensaje, Receptor, Prediccion) :-
    esMensaje(Mensaje),
    not(fraseCelebre(Mensaje)),
    ultimaPalabra(Mensaje, UltimaPalabra),
    fueEscritaDespuesDe(UltimaPalabra, Prediccion),
    esAceptableGrupoOIndividual(Prediccion, Receptor).

ultimaPalabra(Mensaje, Palabra) :-
    length(Mensaje, Cantidad),
    nth1(Cantidad, Mensaje, Palabra).

fueEscritaDespuesDe(Palabra1, Palabra2) :-
    esMensaje(Mensaje),
    nth1(Posicion, Mensaje, Palabra1),
    PosicionSiguiente is Posicion + 1,
    nth1(PosicionSiguiente, Mensaje, Palabra2).

esAceptableGrupoOIndividual(Mensaje, Persona) :-
    persona(Persona),
    esAceptable(Mensaje, Persona).
esAceptableGrupoOIndividual(Mensaje, Personas) :-
    esMensaje(Mensaje),
    forall(member(Persona, Personas), esAceptable(Mensaje, Persona)).