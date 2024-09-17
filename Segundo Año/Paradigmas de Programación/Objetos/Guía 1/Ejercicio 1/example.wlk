object pepita {
  var energia = 100
  var lugar = buenosAires

  method volar(kilometros) {
    energia -= (kilometros + 10)
  }

  method comer(gramos) {
    energia += 4 * gramos
  }

  method dondeEsta() {
    return lugar
  }
  
  method irA(destino) {
    lugar = destino
    self.volar(calculadorDistancias.distanciaEntre(lugar, destino))
  }

  method puedeIrA(destino) {
    return self.leDaLaEnergia(calculadorDistancias.distanciaEntre(lugar, destino))
  }

  method leDaLaEnergia(kilometros) {
    return energia >= (kilometros + 10)
  }
}

object buenosAires {
  const kilometros = 100

  method kilometros() {
    return kilometros
  }
}

object calculadorDistancias {
  method distanciaEntre(origen, destino) {
    return math.abs(origen.kilometros() - destino.kilometros())
  }
}

object math {
  method abs(numero) {
    if(numero < 0) {
      return -numero
    } else {
      return numero
    }
  }
}