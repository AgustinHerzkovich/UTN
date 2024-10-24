import Nave.*
class Tarea {
  const itemsNecesarios

  method puedeRealizarla(unJugador) =
    itemsNecesarios.all { item => unJugador.tiene(item) }

  method realizatePor(unJugador) {
    self.afectarA(unJugador)
    self.usarItemsNecesarios(unJugador)
  }

  method usarItemsNecesarios(unJugador) {
    itemsNecesarios.forEach { item => unJugador.usar(item) }
  }

  method afectarA(unJugador)
}

class ArreglarTablero inherits Tarea(itemsNecesarios = ["llave inglesa"]) {
  override method afectarA(unJugador) {
    unJugador.aumentarSospecha(10)
  }
}

object sacarBasura inherits Tarea(itemsNecesarios = ["escoba", "bolsa consorcio"]){
  override method afectarA(unJugador) {
    unJugador.disminuirSospecha(4)
  }
}

object ventilarNave inherits Tarea(itemsNecesarios = []) {
  override method afectarA(unJugador) {
    nave.aumentarOxigeno(5)
  }
}