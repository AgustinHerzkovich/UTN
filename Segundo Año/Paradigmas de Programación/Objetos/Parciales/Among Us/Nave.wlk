object nave {
  var nivelOxigeno = 100
  var cantidadImpostores = 0
  var cantidadTripulantes = 0

  const jugadores = []

  method aumentarOxigeno(unaCantidad) {
    nivelOxigeno += unaCantidad
  }

  method terminarTarea() {
    if (self.seCompletaronTodasLasTareas()) {
      throw new DomainException(message = "Ganaron los tripulantes")
    }
  }

  method seCompletaronTodasLasTareas() =
    jugadores.all { jugador => jugador.completoSusTareas() }

  method alguienTieneTuboDeOxigeno() =
    jugadores.any { jugador => jugador.tiene("tubo de oxigeno") }

  method reducirOxigeno(unaCantidad) {
    nivelOxigeno -= unaCantidad
    self.validarGanaronImpostores()
  }

  method validarGanaronImpostores() {
    if (nivelOxigeno <= 0 or cantidadImpostores == cantidadTripulantes) {
      throw new DomainException(message = "Ganaron los impostores")
    }
  }

  method llamarReunionDeEmergencia() {
    const losVotitos = self.jugadoresVivos().map { jugador => jugador.voto() }
    const elMasVotado = losVotitos.max { alguien => losVotitos.occurrencesOf(alguien) }
    elMasVotado.expulsar()
  }

  method jugadoresVivos() =
    jugadores.filter { jugador => jugador.estaVivo() }

  method jugadorNoSospechoso() =
    self.jugadoresVivos().findOrDefault({ jugador => !jugador.esSospechoso() }, votoEnBlanco)

  method jugadorSinItems() =
    self.jugadoresVivos().findOrDefault({ jugador => !jugador.tieneItems() }, votoEnBlanco)

  method jugadorMasSospechoso() =
    self.jugadoresVivos().max { jugador => jugador.nivelSospecha() }

  method cualquierJugadorVivo() = self.jugadoresVivos().anyOne()

  method expulsarTripulante() {
    cantidadTripulantes -= 1
    self.validarGanaronImpostores()
  }

  method expulsarImpostor() {
    cantidadImpostores -= 1
    if (cantidadImpostores == 0) {
      throw new DomainException(message = "Ganaron los tripulantes")
    }
  }
}

object votoEnBlanco {
  method expulsar() {
    // No hace nada
  }
}