class Invitado {
    var property disfraz
    const edad
    var personalidad

    method cambiarDisfraz(nuevoDisfraz) {
        disfraz = nuevoDisfraz
    }

    method estaConformeConSuDisfraz() = disfraz.puntaje() > 10

    method tieneDisfraz() = disfraz.existe()

    method esSexie() = personalidad.esSexie(self)

    method tieneMenosDe30Anios() = edad > 30

    method cambiarPersonalidad(nuevaPersonalidad) {
        personalidad = nuevaPersonalidad
    }
}

class Caprichoso inherits Invitado {
    override method estaConformeConSuDisfraz() = super() and disfraz.nombreConLetrasPares()
}

class Pretencioso inherits Invitado {
    override method estaConformeConSuDisfraz() = super() and disfraz.estaHechoHaceMenosDe30Dias()
}

class Numerologo inherits Invitado {
    const cifra

    override method estaConformeConSuDisfraz() = super() and disfraz.puntaje() == cifra
}

// Personalidades
object alegre {
    method esSexie(_persona) = false
}

object taciturna {
    method esSexie(persona) = persona.tieneMenosDe30Anios()
}