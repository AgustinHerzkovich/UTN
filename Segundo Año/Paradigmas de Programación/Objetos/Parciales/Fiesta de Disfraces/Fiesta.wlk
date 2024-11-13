class Fiesta {
    const lugar
    const fecha
    const invitados = []

    method ocurre2OMasDiasDespuesDe(dia) = fecha.day() - dia >= 2

    method esUnBodrio() = invitados.all{invitado => ! invitado.estaConformeConSuDisfraz()}

    method mejorDisfraz() = self.disfraces().max{disfraz => disfraz.puntaje()}

    method disfraces() = invitados.map{invitado => invitado.disfraz()}

    method puedenIntercambiarDisfraz(invitado1, invitado2) = self.estanEnLaFiesta(invitado1, invitado2) and self.algunoEstaDisconformeConSuDisfraz(invitado1, invitado2) and self.luegoDelCambioEstanConformes(invitado1, invitado2)

    method estanEnLaFiesta(invitado1, invitado2) = self.estaEnLaFiesta(invitado1) and self.estaEnLaFiesta(invitado2)

    method estaEnLaFiesta(invitado) = invitados.contains(invitado)

    method algunoEstaDisconformeConSuDisfraz(invitado1, invitado2) = ! invitado1.estaConformeConSuDisfraz() || ! invitado2.estaConformeConSuDisfraz()

    method luegoDelCambioEstanConformes(invitado1, invitado2) {
        const disfraz1 = invitado1.disfraz()
        const disfraz2 = invitado2.disfraz()
        invitado1.disfraz(disfraz2)
        invitado2.disfraz(disfraz1)
        return invitado1.estaConformeConSuDisfraz() and invitado2.estaConformeConSuDisfraz()
    }

    method agregarAsistente(asistente) {
        self.validarAsistente(asistente)
        invitados.add(asistente)
    }

    method validarAsistente(asistente) {
        if (! self.acepta(asistente)) {
            throw new DomainException(message = "No se puede agregar al asistente")
        }
    }

    method acepta(asistente) = asistente.tieneDisfraz() and ! self.estaEnLaFiesta(asistente)
}

class FiestaInolvidable inherits Fiesta {
    override method acepta(asistente) = super(asistente) and asistente.esSexie() and asistente.estaConformeConSuDisfraz()
}