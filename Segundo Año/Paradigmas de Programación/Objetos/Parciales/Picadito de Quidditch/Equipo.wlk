class Equipo {
    const property jugadores = #{}
    var puntos = 0

    method tieneUnJugadorEstrellaContra(otroEquipo) = jugadores.any{jugador => jugador.esEstrellaContra(otroEquipo)}

    method jugarContra(otroEquipo) = jugadores.forEach{jugador => jugador.jugarTurno(otroEquipo)}

    method ganarPuntos(unaCantidad) {
        puntos += unaCantidad
    }

    method intentarBloquear(unCazador) {
        const bloqueador = jugadores.find{jugador => jugador.puedeBloquear(unCazador)}
        if (bloqueador != null) {
            unCazador.perderSkills(2)
            bloqueador.ganarSkills(10)
        }
        unCazador.perderQuaffle()
        self.cazadorMasRapido().atraparQuaffle()
    }

    method cazadorMasRapido() = self.cazadores().max{cazador => cazador.velocidad()}

    method cazadores() = jugadores.filter{jugador => jugador.esCazador()}

    method entregarBlancoUtil() = jugadores.find{jugador => jugador.esBlancoUtil()}

    method tieneLaQuaffle() = self.cazadores().any{cazador => cazador.tieneLaQuaffle()}
}