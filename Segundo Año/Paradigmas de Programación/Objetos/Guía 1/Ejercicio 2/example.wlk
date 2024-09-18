// example.wlk
// example.wlk
object tom {
  var energia = 100

  method energia() {
    return energia
  }

  method velocidad() {
    return 5 + energia / 10
  }

  method comer(raton) {
    energia += 12 + raton.peso()
  }

  method correr(segundos) {
    self.correrDistancia(self.velocidad() * segundos)
  }

  method correrDistancia(unaDistancia) {
    energia -= 0.5 * unaDistancia
  }

  method meConvieneComerRatonA(unRaton, unaDistancia) {
    const energiaGanada = 12 + unRaton.peso()
    const energiaConsumida = 0.5 * unaDistancia
    return energiaGanada > energiaConsumida
  }
}

object jerry {
  const peso = 5

  method peso() {
    return peso
  }
}