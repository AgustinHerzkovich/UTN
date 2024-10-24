import Nave.*

class Jugador {
  var estaVivo = true
  var puedoVotar = true
  var nivelSospecha = 40
  var personalidad

  const mochila = []

  method nivelSospecha() = nivelSospecha

  method esSospechoso() = nivelSospecha > 50

  method buscarItem(unItem) {
    mochila.add(unItem)
  }

  method aumentarSospecha(unaCantidad) {
    nivelSospecha += unaCantidad
  }

  method disminuirSospecha(unaCantidad) {
    nivelSospecha -= unaCantidad
  }

  method tiene(unItem) = mochila.contains(unItem)

  method tieneItems() = !mochila.isEmpty()

  method usar(unItem) {
    mochila.remove(unItem)
  }

  method impugnarVoto() {
    puedoVotar = false
  }

  method llamarReunionDeEmergencia() {
    nave.llamarReunionDeEmergencia()
  }

  method estaVivo() = estaVivo
}

class Tripulante inherits Jugador {
  const tareas = []

  method completoSusTareas() = tareas.isEmpty()

  method realizarTarea() {
    const tarea = self.tareaPendienteHacible()
    tarea.realizatePor(self)
    tareas.remove(tarea)
    nave.terminarTarea()
  }

  method tareaPendienteHacible() = tareas.find { tarea => tarea.puedeRealizarla(self) }

  method voto() = if (puedoVotar) {
    personalidad.voto()
  } else {
    self.votarEnBlanco()
  }

  method votarEnBlanco() {
    puedoVotar = true
    return votoEnBlanco  // EL CASO PROHIBIDO
  }

  method expulsar() {
    estaVivo = false
    nave.expulsarTripulante()
  }
}

class Impostor inherits Jugador {
  method completoSusTareas() = true

  method realizarTarea() {
    // No hace nada
  }

  method realizarSabotaje(unSabotaje) {
    self.aumentarSospecha(5)
    unSabotaje.realizate()
  }

  method voto() = nave.cualquierJugadorVivo()

  method expulsar() {
    estaVivo = false
    nave.expulsarImpostor()
  }
}