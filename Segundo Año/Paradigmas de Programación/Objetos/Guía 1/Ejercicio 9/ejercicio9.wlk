// Ejercicio%209/ejercicio9.wlk
/*
Problema 1: Estudiante que desea anotarse en las materias
Objetos involucrados:

Estudiante

Atributos: nombre, materiasAnotadas (lista de materias).
Métodos: anotarse(materia), consultarMaterias(), verificarCorrelativas(materia).
Materia

Atributos: nombre, horario, profesor, correlativas (lista de materias).
Métodos: consultarProfesor(), consultarHorario().
Curso

Atributos: materia, horario, cupo.
Métodos: esHorarioValido(hora), consultarDisponibilidad().
Profesor

Atributos: nombre, materiasQueDicta (lista de materias).
Métodos: consultarMaterias().
Colaboración:

El Estudiante consulta las Materias disponibles.
El Estudiante verifica si tiene las Correlativas necesarias para anotarse en una materia.
El Estudiante se anota en una Materia, lo que implica que verifica que no esté en conflicto con el horario de otros cursos que ya tiene anotados.
Cada Materia puede consultar su Profesor para obtener información sobre el docente que la imparte.
Mensajes enviados:

estudiante.consultarMaterias()
materia.consultarProfesor()
estudiante.verificarCorrelativas(materia)
curso.esHorarioValido(hora)
estudiante.anotarse(materia)
Problema 2: Zorro buscando alimento en un gallinero
Objetos involucrados:

Zorro

Atributos: nombre, hambre, energía.
Métodos: buscarComida(gallinero), comer(comida).
Gallinero

Atributos: gallinas, patos, gallos, huevos.
Métodos: consultarComidaDisponibles(), removerComida(comida).
Comida (Gallina, Pato, Gallo, Huevo)

Atributos: energía, sabor, peligrosidad.
Métodos: evaluarPeligrosidad(), obtenerEnergia(), obtenerSabor().
Entorno (puede ser un objeto que represente el contexto del gallinero)

Atributos: seguridad, peligro.
Métodos: evaluarSeguridad(zorro).
Colaboración:

El Zorro busca comida en el Gallinero.
El Gallinero proporciona información sobre la Comida disponible (gallinas, patos, gallos, huevos).
Cada tipo de Comida evalúa su Peligrosidad antes de ser consumida por el Zorro.
El Entorno puede influir en la decisión del Zorro sobre si acercarse a ciertos tipos de comida.
Mensajes enviados:

zorro.buscarComida(gallinero)
gallinero.consultarComidaDisponibles()
comida.evaluarPeligrosidad()
zorro.comer(comida)
entorno.evaluarSeguridad(zorro)
*/