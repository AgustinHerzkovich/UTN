// Aves
object pepita {
  var energia = 100
  var lugar = buenosAires
  var entrenador = roque

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
    if (self.puedeIrA(destino)) {
        lugar = destino
        self.volar(calculadorDistancias.distanciaEntre(lugar, destino))
    }
  }

  method puedeIrA(destino) {
    return self.leDaLaEnergia(calculadorDistancias.distanciaEntre(lugar, destino))
  }

  method leDaLaEnergia(kilometros) {
    return energia >= (kilometros + 10)
  }

  method hacerDeseo() {
    self.estado().cumplirDeseo(self)
  }

  method estado() {
    if (energia < 50) {
        return debil
    } else if (energia> 500 && energia.even()) {
        return euforia
    } else {
       return null // Indefinido
    }
  }

  method entrenate() {
    entrenador.rutina(self)
  }

  method entrenador(_entrenador) {
    entrenador = _entrenador
  }
}

object pepon {
    var energia = 100
    var entrenador = susana

    method volar(kilometros) {
        energia -= kilometros * 2
    }

    method comer(gramos) {
        energia += 3 * gramos - 20
    }

    method hacerDeseo() {
        self.comer(100)
    }

    method entrenate() {
        entrenador.rutina(self)
    }
}

object luciana {
    var energia = 100
    var lugar = buenosAires
    var entrenador = roque

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
    if (self.puedeIrA(destino)) {
        lugar = destino
        self.volar(calculadorDistancias.distanciaEntre(lugar, destino))
    }
  }

  method puedeIrA(destino) {
    return self.leDaLaEnergia(calculadorDistancias.distanciaEntre(lugar, destino))
  }

  method leDaLaEnergia(kilometros) {
    return energia >= (kilometros + 10)
  }

  method hacerDeseo() {
    self.estado().cumplirDeseo(self)
  }

  method estado() {
    if (energia < 50) {
        return debil
    } else if (energia> 500 && energia.even()) {
        return euforia
    } else {
       return null // Indefinido
    }
  }

  method entrenate() {
    entrenador.rutina(self)
  }

  method entrenador(_entrenador) {
    entrenador = _entrenador
  }
}

object ernestina {
    var energia = 100
    var lugar = buenosAires
    var entrenador = roque
    
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
    if (self.puedeIrA(destino)) {
        lugar = destino
        self.volar(calculadorDistancias.distanciaEntre(lugar, destino))
    }
  }

  method puedeIrA(destino) {
    return self.leDaLaEnergia(calculadorDistancias.distanciaEntre(lugar, destino))
  }

  method leDaLaEnergia(kilometros) {
    return energia >= (kilometros + 10)
  }

  method hacerDeseo() {
    self.estado().cumplirDeseo(self)
  }

  method estado() {
    if (energia < 50) {
        return debil
    } else if (energia> 500 && energia.even()) {
        return euforia
    } else {
       return null // Indefinido
    }
  }

  method entrenate() {
    entrenador.rutina(self)
  }

  method entrenador(_entrenador) {
    entrenador = _entrenador
  }
}

// Destinos
object buenosAires {
  const kilometros = 100

  method kilometros() {
    return kilometros
  }
}

// Calculador de distancias
object calculadorDistancias {
  method distanciaEntre(origen, destino) {
    return (origen.kilometros() - destino.kilometros()).abs()
  }
}

// Estados
object euforia {
    method cumplirDeseo(ave) {
        ave.volar(5)
    }
}

object debil {
    method cumplirDeseo(ave) {
        ave.comer(500)
    }
}

// Entrenadores
object roque {
    method rutina(ave) {
        ave.volar(5)
        ave.comer(300)
        ave.volar(3)
    }
}

object susana {
    method rutina(ave) {
        ave.volar(3)
        ave.hacerDeseo()
    }
}